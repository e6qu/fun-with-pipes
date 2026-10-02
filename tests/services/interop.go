// Interoperability checks for fwp services against Go's HTTP/2
// implementation, whose HPACK encoder uses Huffman coding and the dynamic
// table. Used by tests/services.rs when `go` is installed.
//
//	go run interop.go server            serve fwp.Echo/Shout on a free port
//	                                     (prints the address)
//	go run interop.go client ADDR PATH HEX
//	                                     call PATH twice on one connection
//	                                     with the request message HEX; print
//	                                     the protocol, grpc-status and the
//	                                     response body in hex
package main

import (
	"bytes"
	"encoding/binary"
	"encoding/hex"
	"fmt"
	"io"
	"net"
	"net/http"
	"os"
	"strings"
)

func frame(msg []byte) []byte {
	b := make([]byte, 5+len(msg))
	binary.BigEndian.PutUint32(b[1:], uint32(len(msg)))
	copy(b[5:], msg)
	return b
}

func h2c() *http.Protocols {
	var p http.Protocols
	p.SetUnencryptedHTTP2(true)
	return &p
}

func main() {
	switch os.Args[1] {
	case "server":
		ln, err := net.Listen("tcp", "127.0.0.1:0")
		if err != nil {
			panic(err)
		}
		fmt.Println(ln.Addr())
		h := func(w http.ResponseWriter, r *http.Request) {
			body, _ := io.ReadAll(r.Body)
			w.Header().Set("Content-Type", "application/grpc")
			if r.URL.Path != "/fwp.Echo/Shout" || len(body) < 7 || body[5] != 0x0a {
				w.Header().Set("Grpc-Status", "12")
				w.Header().Set("Grpc-Message", "unknown method "+r.URL.Path)
				w.WriteHeader(200)
				return
			}
			s := string(body[7 : 7+int(body[6])])
			out := strings.ToUpper(s) + "!"
			w.Header().Set("Trailer", "Grpc-Status")
			w.WriteHeader(200)
			w.Write(frame(append([]byte{0x0a, byte(len(out))}, out...)))
			w.Header().Set("Grpc-Status", "0")
		}
		srv := &http.Server{Handler: http.HandlerFunc(h), Protocols: h2c()}
		srv.Serve(ln)
	case "client":
		msg, _ := hex.DecodeString(os.Args[4])
		c := &http.Client{Transport: &http.Transport{Protocols: h2c()}}
		for i := 0; i < 2; i++ {
			req, _ := http.NewRequest("POST", "http://"+os.Args[2]+os.Args[3], bytes.NewReader(frame(msg)))
			req.Header.Set("Content-Type", "application/grpc")
			req.Header.Set("Te", "trailers")
			resp, err := c.Do(req)
			if err != nil {
				fmt.Println("error:", err)
				os.Exit(1)
			}
			body, _ := io.ReadAll(resp.Body)
			resp.Body.Close()
			status := resp.Trailer.Get("Grpc-Status")
			if status == "" {
				status = resp.Header.Get("Grpc-Status")
			}
			fmt.Printf("%s %s %s\n", resp.Proto, status, hex.EncodeToString(body))
		}
	}
}

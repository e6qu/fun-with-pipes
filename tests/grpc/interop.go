// A gRPC client built on Go's standard HTTP/2 implementation, for
// tests/grpc.rs (when `go` is installed): it calls the service of
// tests/grpc/greeter.fwp with streaming, metadata and a deadline, and
// prints what it receives.
//
//	go run interop.go ADDR
package main

import (
	"bytes"
	"encoding/binary"
	"encoding/hex"
	"fmt"
	"io"
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

// call a method with request messages and headers; print the response
// messages in hex and the status
func call(c *http.Client, addr, path string, headers map[string]string, msgs ...[]byte) {
	var body bytes.Buffer
	for _, m := range msgs {
		body.Write(frame(m))
	}
	req, err := http.NewRequest("POST", "http://"+addr+path, &body)
	if err != nil {
		panic(err)
	}
	req.Header.Set("Content-Type", "application/grpc")
	req.Header.Set("TE", "trailers")
	for k, v := range headers {
		req.Header.Set(k, v)
	}
	resp, err := c.Do(req)
	if err != nil {
		fmt.Println("error:", err)
		return
	}
	data, _ := io.ReadAll(resp.Body)
	resp.Body.Close()
	var out []string
	for len(data) >= 5 {
		n := int(binary.BigEndian.Uint32(data[1:5]))
		if len(data) < 5+n {
			break
		}
		out = append(out, hex.EncodeToString(data[5:5+n]))
		data = data[5+n:]
	}
	status := resp.Trailer.Get("Grpc-Status")
	if status == "" {
		status = resp.Header.Get("Grpc-Status")
	}
	message := resp.Trailer.Get("Grpc-Message")
	if message == "" {
		message = resp.Header.Get("Grpc-Message")
	}
	fmt.Printf("%s %s [%s] %s %s\n", resp.Proto, path, strings.Join(out, " "), status, message)
}

func main() {
	addr := os.Args[1]
	c := &http.Client{Transport: &http.Transport{Protocols: h2c()}}
	// unary: HelloRequest{name: "go"}
	call(c, addr, "/test.Greeter/SayHello", nil, []byte{0x0a, 0x02, 'g', 'o'})
	// server streaming: Count 3 (sint64 3 is 6)
	call(c, addr, "/test.Greeter/Count", nil, []byte{0x08, 0x06})
	// client streaming: Total of 1, 2, 3
	call(c, addr, "/test.Greeter/Total", nil, []byte{0x08, 0x02}, []byte{0x08, 0x04}, []byte{0x08, 0x06})
	// bidirectional: Shout "a", "b"
	call(c, addr, "/test.Greeter/Shout", nil, []byte{0x0a, 0x01, 'a'}, []byte{0x0a, 0x01, 'b'})
	// metadata
	call(c, addr, "/test.Greeter/Whoami", map[string]string{"x-user": "gopher"}, []byte{})
	// a deadline the server enforces: Nap 2000 ms within 100 ms
	call(c, addr, "/test.Greeter/Nap", map[string]string{"grpc-timeout": "100m"}, []byte{0x08, 0xa0, 0x1f})
	// statuses
	call(c, addr, "/test.Greeter/Find", nil, []byte{0x0a, 0x05, 'g', 'h', 'o', 's', 't'})
	call(c, addr, "/test.Greeter/Nope", nil, []byte{})
	call(c, addr, "/test.Greeter/SayHello", nil, []byte{0xff})
	// health checking
	call(c, addr, "/grpc.health.v1.Health/Check", nil, []byte{})
}

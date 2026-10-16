#include <stdint.h>
#include <stdio.h>
#define OWNED_COUNT 1
#ifdef _WIN32
#include <winsock2.h>
#include <windows.h>
typedef SOCKET test_socket;
static int socket_live(test_socket s) {
    int type=0, len=sizeof type; return getsockopt(s,SOL_SOCKET,SO_TYPE,(char *)&type,&len)==0;
}
#else
#include <dlfcn.h>
#include <sys/socket.h>
#include <unistd.h>
typedef int test_socket;
static int socket_live(test_socket s) {
    int type=0; socklen_t len=sizeof type; return getsockopt(s,SOL_SOCKET,SO_TYPE,&type,&len)==0;
}
#endif
int main(int argc,char **argv) {
    if(argc!=2) return 246;
#ifdef _WIN32
    WSADATA data; if(WSAStartup(MAKEWORD(2,2),&data)) return 246;
#endif
    test_socket borrowed=socket(AF_INET,SOCK_DGRAM,0);
    if(!socket_live(borrowed)) return 246;
    for(int cycle=0;cycle<3;cycle++) {
#ifdef _WIN32
        HMODULE library=LoadLibraryA(argv[1]); if(!library) return 245;
        void (*setup)(uintptr_t *)=(void (*)(uintptr_t *))GetProcAddress(library,"setup");
#else
        void *library=dlopen(argv[1],RTLD_NOW|RTLD_LOCAL);
        if(!library) { fprintf(stderr,"%s\n",dlerror()); return 245; }
        void (*setup)(uintptr_t *)=(void (*)(uintptr_t *))dlsym(library,"setup");
#endif
        if(!setup) return 244;
        uintptr_t owned[OWNED_COUNT]; setup(owned);
        for(int i=0;i<OWNED_COUNT;i++) if(!socket_live((test_socket)owned[i])) return 247;
        if(!socket_live(borrowed)) return 247;
#ifdef _WIN32
        if(!FreeLibrary(library)) return 243;
#else
        if(dlclose(library)) return 243;
#endif
        for(int i=0;i<OWNED_COUNT;i++) if(socket_live((test_socket)owned[i])) return 248;
        if(!socket_live(borrowed)) return 242;
    }
#ifdef _WIN32
    closesocket(borrowed); WSACleanup();
#else
    close(borrowed);
#endif
    puts("Socket unload: three library cycles close retained owners and preserve the host socket");
    return 0;
}

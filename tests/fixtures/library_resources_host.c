#include <stdint.h>
#include <stdio.h>
#include <errno.h>
#ifdef _WIN32
#include <winsock2.h>
#include <windows.h>
typedef SOCKET test_socket;
static void close_socket(test_socket s) { closesocket(s); }
static int file_closed(uintptr_t handle) {
    SetLastError(0);
    return GetFileType((HANDLE)handle)==FILE_TYPE_UNKNOWN && GetLastError()==ERROR_INVALID_HANDLE;
}
#else
#include <dlfcn.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/socket.h>
typedef int test_socket;
static void close_socket(test_socket s) { close(s); }
static int file_closed(uintptr_t fd) { return fcntl((int)fd,F_GETFD)==-1 && errno==EBADF; }
#endif
static int socket_live(uintptr_t fd) {
    int type=0;
#ifdef _WIN32
    int len=sizeof type;
#else
    socklen_t len=sizeof type;
#endif
    return getsockopt((test_socket)fd,SOL_SOCKET,SO_TYPE,(char *)&type,&len)==0;
}
int main(int argc,char **argv) {
    if(argc!=5)return 30;
#ifdef _WIN32
    WSADATA data;if(WSAStartup(MAKEWORD(2,2),&data))return 34;
#endif
    for(int cycle=0;cycle<3;cycle++) {
#ifdef _WIN32
        HMODULE lib=LoadLibraryA(argv[1]);if(!lib){fprintf(stderr,"load: %lu\n",GetLastError());return 31;}
        void (*setup)(uintptr_t *,int *,const char *,const char *,const char *)=(void *)GetProcAddress(lib,"setup");
#else
        void *lib=dlopen(argv[1],RTLD_NOW|RTLD_LOCAL);if(!lib){fprintf(stderr,"%s\n",dlerror());return 31;}
        void (*setup)(uintptr_t *,int *,const char *,const char *,const char *)=(void *)dlsym(lib,"setup");
#endif
        if(!setup)return 32;
        uintptr_t fds[15];int counts[8]={0};setup(fds,counts,argv[2],argv[3],argv[4]);
#ifdef _WIN32
        if(!FreeLibrary(lib))return 33;
#else
        if(dlclose(lib))return 33;
#endif
        if(!file_closed(fds[0]))return 1;
        for(int i=1;i<4;i++)if(socket_live(fds[i]))return 1;
        for(int i=7;i<11;i++)if(socket_live(fds[i]))return 1;
        if(counts[0]!=1||counts[1]!=4||counts[2]!=0||counts[3]!=1||counts[4]!=1||counts[5]!=2||counts[6]!=2||counts[7]!=2){fprintf(stderr,"ctx=%d ssl=%d shutdown=%d name=%d cache=%d\n",counts[0],counts[1],counts[2],counts[3],counts[4]);return 2;}
        for(int i=11;i<15;i++){if(!socket_live(fds[i]))return 3;close_socket((test_socket)fds[i]);}
        for(int i=4;i<7;i++){if(!socket_live(fds[i]))return 3;close_socket((test_socket)fds[i]);}
    }
#ifdef _WIN32
    WSACleanup();
#endif
    return 0;
}

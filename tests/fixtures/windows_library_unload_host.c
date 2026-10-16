static int unmapped(void *p) {
 MEMORY_BASIC_INFORMATION info;
 return p&&VirtualQuery(p,&info,sizeof info)==sizeof info&&info.State==MEM_FREE;
}
static SOCKET input_socket(void) {
 SOCKET fd=socket(AF_INET,SOCK_DGRAM,IPPROTO_UDP);
 struct sockaddr_in address={0};address.sin_family=AF_INET;address.sin_addr.s_addr=htonl(INADDR_LOOPBACK);
 if(fd==INVALID_SOCKET||bind(fd,(struct sockaddr *)&address,sizeof address)){fprintf(stderr,"socket setup: %d\n",WSAGetLastError());exit(31);}
 return fd;
}
#ifdef STATIC_HOST
extern const char *cached(void);
extern void setup(struct snapshot *);
static struct snapshot state;
int main(void) {
 WSADATA data;if(WSAStartup(MAKEWORD(2,2),&data))return 30;
 if(strcmp(cached(),"heapheap"))return 33;
 state.socket=(uintptr_t)input_socket();setup(&state);state.static_exit=1;
 if(state.order_error)return 34;
 puts("main");return 0;
}
#else
int main(int argc,char **argv) {
 if(argc!=2)return 30;
 WSADATA data;if(WSAStartup(MAKEWORD(2,2),&data))return 31;
 for(int i=0;i<3;i++) {
  if(i==1&&!ConvertThreadToFiberEx(NULL,FIBER_FLAG_FLOAT_SWITCH))return 32;
  BOOL was_fiber=IsThreadAFiber();
  SOCKET fd=input_socket();
  HMODULE lib=LoadLibraryA(argv[1]);if(!lib){fprintf(stderr,"load: %lu\n",GetLastError());return 32;}
  const char *(*cached)(void)=(const char *(*)(void))GetProcAddress(lib,"cached");
  void (*setup)(struct snapshot *)=(void (*)(struct snapshot *))GetProcAddress(lib,"setup");
  if(!cached||!setup||strcmp(cached(),"heapheap"))return 33;
  static struct snapshot s;memset(&s,0,sizeof s);s.socket=(uintptr_t)fd;setup(&s);
  if(s.order_error||strcmp(cached(),"heapheap"))return 34;
  if(!FreeLibrary(lib))return 35;
  if(!unmapped(s.heap)||!unmapped(s.meta))return 1;
  for(int j=0;j<3;j++)if(!unmapped(s.stacks[j]))return 2;
  if(s.fibers_deleted!=3)return 2;
  if(s.finalized!=1||s.cancelled!=2)return 3;
  if(s.wide_freed!=1||s.fins_freed!=1||s.marks_freed!=1||s.metrics_freed!=1||s.name_freed!=1||s.key_deleted!=1||s.finished!=1)return 4;
  if(s.signal_added!=1||s.signal_removed!=1)return 5;
  if(s.order_error||IsThreadAFiber()!=was_fiber)return 6;
  struct sockaddr_storage address;int size=sizeof address;
  if(getsockname(fd,(struct sockaddr *)&address,&size))return 7;
  closesocket(fd);
  if(was_fiber&&!ConvertFiberToThread())return 8;
 }
 WSACleanup();return 0;
}
#endif

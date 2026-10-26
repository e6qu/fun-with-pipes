#ifdef _WIN32
#include <windows.h>
#else
#include <dlfcn.h>
#endif
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
int main(int argc,char **argv){
    if(argc!=3)return 180;
    for(int round=0;round<3;round++){
#ifdef _WIN32
        HMODULE lib=LoadLibraryA(argv[1]);if(!lib){fprintf(stderr,"LoadLibrary: %lu\n",GetLastError());return 181;}
#define LIBRARY_SYMBOL(name) (void *)GetProcAddress(lib,name)
#else
        void *lib=dlopen(argv[1],RTLD_NOW|RTLD_LOCAL);if(!lib){fprintf(stderr,"%s\n",dlerror());return 181;}
#define LIBRARY_SYMBOL(name) dlsym(lib,name)
#endif
        int64_t (*probe)(int64_t)=0,(*live)(int64_t)=0,(*managed)(int64_t)=0;
        *(void **)(&probe)=LIBRARY_SYMBOL("probe");*(void **)(&live)=LIBRARY_SYMBOL("library_live_probe");
        *(void **)(&managed)=LIBRARY_SYMBOL("managed");
        if(!probe || !live || !managed || probe(129)<0 || live(257)<0 || managed(0)<0)return 184;
#ifdef _WIN32
        if(!FreeLibrary(lib))return 185;
#else
        if(dlclose(lib))return 185;
#endif
        FILE *f=fopen(argv[2],"r");if(!f)return 182;
        size_t owners,calls;int lines=0;
        while(fscanf(f,"%zu %zu",&owners,&calls)==2){if(owners || !calls)return 183;lines++;}
        fclose(f);if(lines!=round+1)return 182;
    }
    return 0;
}

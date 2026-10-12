#include <dlfcn.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
int main(int argc,char **argv){
    if(argc!=3)return 180;
    for(int round=0;round<3;round++){
        void *lib=dlopen(argv[1],RTLD_NOW|RTLD_LOCAL);if(!lib){fprintf(stderr,"%s\n",dlerror());return 181;}
        int64_t (*probe)(int64_t)=0,(*live)(int64_t)=0;
        *(void **)(&probe)=dlsym(lib,"probe");*(void **)(&live)=dlsym(lib,"live");
        if(!probe || !live || probe(129)<0 || live(257)<0)return 184;
        if(dlclose(lib))return 185;
        FILE *f=fopen(argv[2],"r");if(!f)return 182;
        size_t owners,calls;int lines=0;
        while(fscanf(f,"%zu %zu",&owners,&calls)==2){if(owners || !calls)return 183;lines++;}
        fclose(f);if(lines!=round+1)return 182;
    }
    return 0;
}

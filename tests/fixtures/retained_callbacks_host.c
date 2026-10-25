/* A real loader closes and reopens the library; its destructor checks that
 * no registration, capture or task storage survives each unload. */
#include <stdio.h>
#include <stdlib.h>
#ifdef _WIN32
#include <windows.h>
#else
#include <dlfcn.h>
#endif
int main(int argc, char **argv) {
    if (argc != 4) return 240;
    for (unsigned round = 0; round < 3; round++) {
#ifdef _WIN32
        HMODULE library = LoadLibraryA(argv[1]);
        if (!library) return 245;
        int (*probe)(int, unsigned) = (int (*)(int, unsigned))GetProcAddress(library, "callback_probe");
#else
        void *library = dlopen(argv[1], RTLD_NOW | RTLD_LOCAL);
        if (!library) { fprintf(stderr, "%s\n", dlerror()); return 245; }
        int (*probe)(int, unsigned) = (int (*)(int, unsigned))dlsym(library, "callback_probe");
#endif
        if (!probe) return 246;
        int result = probe(atoi(argv[2]), (unsigned)atoi(argv[3]));
        if (result) return result;
#ifdef _WIN32
        if (!FreeLibrary(library)) return 247;
#else
        if (dlclose(library)) return 247;
#endif
    }
    return 0;
}

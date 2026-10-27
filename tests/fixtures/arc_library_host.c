#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#ifdef _WIN32
#include <windows.h>
#else
#include <dlfcn.h>
#endif

int main(int argc, char **argv) {
    if (argc != 3) return 190;
    for (int round = 0; round < 3; ++round) {
#ifdef _WIN32
        HMODULE library = LoadLibraryA(argv[1]);
        if (!library) return 191;
        int (*probe)(void) = (int (*)(void))GetProcAddress(library, "fwp_test_probe");
#else
        void *library = dlopen(argv[1], RTLD_NOW | RTLD_LOCAL);
        if (!library) { fprintf(stderr, "%s\n", dlerror()); return 191; }
        int (*probe)(void) = (int (*)(void))dlsym(library, "fwp_test_probe");
#endif
        if (!probe) return 192;
        int result = probe();
        if (result) return result;
#ifdef _WIN32
        if (!FreeLibrary(library)) return 193;
#else
        if (dlclose(library)) return 193;
#endif
        FILE *file = fopen(argv[2], "r");
        if (!file) return 194;
        char line[64];
        int lines = 0;
        while (fgets(line, sizeof(line), file)) {
            if (strcmp(line, "0\n")) return 195;
            ++lines;
        }
        if (ferror(file) || fclose(file)) return 194;
        if (lines != round + 1) return 194;
    }
    return 0;
}

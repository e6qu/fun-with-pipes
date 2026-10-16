#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#ifdef _WIN32
#define _WIN32_WINNT 0x0a00
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <shellapi.h>
#include <wchar.h>
#include <fcntl.h>
#include <io.h>
int main(void) {
    _setmode(_fileno(stdin), _O_BINARY);
    _setmode(_fileno(stdout), _O_BINARY);
    _setmode(_fileno(stderr), _O_BINARY);
    int count;
    wchar_t **wide = CommandLineToArgvW(GetCommandLineW(), &count);
    if (!wide) return 101;
    char **args = (char **)calloc((size_t)count, sizeof *args);
    if (!args) return 105;
    for (int i = 0; i < count; i++) {
        int bytes = WideCharToMultiByte(CP_UTF8, 0, wide[i], -1, NULL, 0, NULL, NULL);
        args[i] = (char *)malloc((size_t)bytes);
        if (!args[i] || !WideCharToMultiByte(CP_UTF8, 0, wide[i], -1, args[i], bytes, NULL, NULL)) return 105;
    }
    LocalFree(wide);
#else
int main(int count, char **args) {
#endif
    int status = 7;
    if (count > 1 && !strcmp(args[1], "success")) {
        fputs("ok\n", stdout); status = 0;
    } else if (count > 1 && !strcmp(args[1], "failure")) {
        fputs(" expected failure \n", stderr);
    } else if (count > 1 && !strcmp(args[1], "pump")) {
        char data[65536]; memset(data, 'e', sizeof data);
        if (fwrite(data, 1, sizeof data, stderr) != sizeof data) return 102;
        memset(data, 'o', sizeof data);
        if (fwrite(data, 1, sizeof data, stdout) != sizeof data) return 103;
        fflush(stdout); fflush(stderr);
        size_t input = 0, got;
        while ((got = fread(data, 1, sizeof data, stdin))) input += got;
        if (input != 200000) return 104;
    } else if (count <= 1 || strcmp(args[1], "silent")) {
        for (int i = 1; i < count; i++) printf("%zu:%s\n", strlen(args[i]), args[i]);
    }
#ifdef _WIN32
    for (int i = 0; i < count; i++) free(args[i]);
    free(args);
#endif
    return status;
}

#define _WIN32_WINNT 0x0a00
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <shellapi.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <wchar.h>
#include <fcntl.h>
#include <io.h>
int main(void) {
    _setmode(_fileno(stdin), _O_BINARY);
    _setmode(_fileno(stdout), _O_BINARY);
    _setmode(_fileno(stderr), _O_BINARY);
    int count;
    wchar_t **args = CommandLineToArgvW(GetCommandLineW(), &count);
    if (!args) return 101;
    if (count > 1 && !wcscmp(args[1], L"pump")) {
        char data[65536]; memset(data, 'e', sizeof data);
        if (fwrite(data, 1, sizeof data, stderr) != sizeof data) return 102;
        memset(data, 'o', sizeof data);
        if (fwrite(data, 1, sizeof data, stdout) != sizeof data) return 103;
        fflush(stdout); fflush(stderr);
        size_t input = 0, got;
        while ((got = fread(data, 1, sizeof data, stdin))) input += got;
        if (input != 200000) return 104;
    } else {
        for (int i = 1; i < count; i++) {
            int bytes = WideCharToMultiByte(CP_UTF8, 0, args[i], -1, NULL, 0, NULL, NULL);
            char *text = (char *)malloc((size_t)bytes);
            if (!text || !WideCharToMultiByte(CP_UTF8, 0, args[i], -1, text, bytes, NULL, NULL)) return 105;
            printf("%d:%s\n", bytes - 1, text);
            free(text);
        }
    }
    LocalFree(args);
    return 7;
}

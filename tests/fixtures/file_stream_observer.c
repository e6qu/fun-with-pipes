/* Capture the OS identity while FILE is live. Inspecting the closed descriptor
 * must not dereference FILE or call a Windows CRT function on an invalid fd. */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <errno.h>
#ifdef _WIN32
#ifndef _WIN32_WINNT
#define _WIN32_WINNT 0x0a00
#endif
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <windows.h>
#include <io.h>
#include <wchar.h>
#else
#include <fcntl.h>
#include <unistd.h>
#endif
static FILE *watched_stream;
#ifdef _WIN32
static HANDLE watched_native;
static FILE *observe_wopen(const wchar_t *path, const wchar_t *mode) {
    FILE *stream = _wfopen(path, mode);
    if (stream) {
        watched_stream = stream;
        watched_native = (HANDLE)_get_osfhandle(_fileno(stream));
        if (watched_native == INVALID_HANDLE_VALUE) _Exit(32);
    }
    return stream;
}
static int stream_is_open(void) {
    BY_HANDLE_FILE_INFORMATION information;
    if (GetFileInformationByHandle(watched_native, &information)) return 1;
    if (GetLastError() != ERROR_INVALID_HANDLE) _Exit(31);
    return 0;
}
#else
static int watched_fd;
static FILE *observe_open(const char *path, const char *mode) {
    FILE *stream = fopen(path, mode);
    if (stream) {
        watched_stream = stream; watched_fd = fileno(stream);
        if (watched_fd < 0) _Exit(32);
    }
    return stream;
}
static int stream_is_open(void) {
    if (fcntl(watched_fd, F_GETFD) != -1) return 1;
    if (errno != EBADF) _Exit(31);
    return 0;
}
#endif

/* UTF-8 language strings cross Windows APIs as UTF-16. Short paths use
 * stack scratch; longer strings own their temporary conversion buffer. */
#ifdef _WIN32
#include <io.h>
#include <limits.h>
#include <fcntl.h>
#include <wchar.h>
#include <shellapi.h>

typedef struct { wchar_t *text; wchar_t local[512]; } fwp_win_text;
static int fwp_win_text_init(fwp_win_text *text, const char *bytes, size_t length) {
    text->text = NULL;
    if (length > INT_MAX || memchr(bytes, 0, length)) { errno = EINVAL; return 0; }
    int size = length ? MultiByteToWideChar(CP_UTF8, MB_ERR_INVALID_CHARS, bytes, (int)length, NULL, 0) : 0;
    if (length && !size) { errno = EILSEQ; return 0; }
    wchar_t *wide = (size_t)size < sizeof text->local / sizeof *text->local
                       ? text->local : (wchar_t *)malloc(((size_t)size + 1) * sizeof(wchar_t));
    if (!wide) { errno = ENOMEM; return 0; }
    if (size && !MultiByteToWideChar(CP_UTF8, MB_ERR_INVALID_CHARS, bytes, (int)length, wide, size)) {
        if (wide != text->local) free(wide);
        errno = EILSEQ;
        return 0;
    }
    wide[size] = 0;
    text->text = wide;
    return 1;
}
static void fwp_win_text_finish(void *pointer) {
    fwp_win_text *text = (fwp_win_text *)pointer;
    if (text->text != text->local) free(text->text);
    text->text = NULL;
}
static void fwp_win_free(void *pointer) { free(pointer); }
static void fwp_win_close(void *pointer) {
    HANDLE *handle = (HANDLE *)pointer;
    if (*handle && *handle != INVALID_HANDLE_VALUE) CloseHandle(*handle);
    *handle = INVALID_HANDLE_VALUE;
}
static V fwp_win_string(const wchar_t *wide, size_t length) {
    if (length > INT_MAX) fwp_trap("Windows string too large");
    if (!length) return fwp_cstr("");
    int size = WideCharToMultiByte(CP_UTF8, 0, wide, (int)length, NULL, 0, NULL, NULL);
    if (!size) fwp_trap("cannot encode Windows string");
    char local[1024], *bytes = size <= (int)sizeof local ? local : (char *)malloc((size_t)size);
    if (!bytes) fwp_trap("out of memory converting Windows string");
    fwp_cleanup cleanup;
    if (bytes != local) fwp_cleanup_push(&cleanup, fwp_win_free, bytes);
    if (!WideCharToMultiByte(CP_UTF8, 0, wide, (int)length, bytes, size, NULL, NULL))
        fwp_trap("cannot encode Windows string");
    V result = fwp_str_new(bytes, (size_t)size);
    if (bytes != local) { fwp_cleanup_pop(&cleanup); free(bytes); }
    return result;
}
static FILE *fwp_path_fopen(V path, const char *mode) {
    fwp_win_text wide;
    if (!fwp_win_text_init(&wide, STR(path)->d, STR(path)->len)) return NULL;
    wchar_t wide_mode[8];
    size_t n = strlen(mode);
    if (n >= 8) abort(); /* all callers use fixed CRT modes */
    for (size_t i = 0; i <= n; i++) wide_mode[i] = (unsigned char)mode[i];
    FILE *file = _wfopen(wide.text, wide_mode);
    int error = errno;
    fwp_win_text_finish(&wide);
    errno = error;
    return file;
}
static int fwp_win_env_text(const char *name, size_t length, V *out) {
    fwp_win_text wide;
    if (!fwp_win_text_init(&wide, name, length)) return 0;
    SetLastError(ERROR_SUCCESS);
    DWORD size = GetEnvironmentVariableW(wide.text, NULL, 0);
    if (!size) {
        DWORD error = GetLastError();
        fwp_win_text_finish(&wide);
        if (error != ERROR_SUCCESS) return 0;
        *out = fwp_cstr("");
        return 1;
    }
    wchar_t *value = (wchar_t *)malloc((size_t)size * sizeof *value);
    if (!value) { fwp_win_text_finish(&wide); fwp_trap("out of memory reading environment"); }
    SetLastError(ERROR_SUCCESS);
    DWORD got = GetEnvironmentVariableW(wide.text, value, size);
    DWORD error = GetLastError();
    fwp_win_text_finish(&wide);
    if (!got && error != ERROR_SUCCESS) { free(value); return 0; }
    if (got >= size) { free(value); fwp_trap("environment changed while reading a value"); }
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_win_free, value);
    *out = fwp_win_string(value, got);
    fwp_cleanup_pop(&cleanup);
    free(value);
    return 1;
}
static V fwp_win_env_get(V name) {
    V value;
    return fwp_win_env_text(STR(name)->d, STR(name)->len, &value) ? fwp_some(value) : FWP_NONE;
}

/* argv is one owned allocation, with UTF-8 strings following its pointers. */
static char **fwp_win_arguments(int *count) {
    wchar_t **wide = CommandLineToArgvW(GetCommandLineW(), count);
    if (!wide) fwp_trap("cannot read command-line arguments");
    size_t size = ((size_t)*count + 1) * sizeof(char *);
    for (int i = 0; i < *count; i++) {
        int bytes = WideCharToMultiByte(CP_UTF8, 0, wide[i], -1, NULL, 0, NULL, NULL);
        if (!bytes || (size_t)bytes > SIZE_MAX - size) { LocalFree(wide); fwp_trap("command line too large"); }
        size += (size_t)bytes;
    }
    char **args = (char **)malloc(size);
    if (!args) { LocalFree(wide); fwp_trap("out of memory reading command line"); }
    char *next = (char *)(args + *count + 1);
    for (int i = 0; i < *count; i++) {
        int bytes = WideCharToMultiByte(CP_UTF8, 0, wide[i], -1, NULL, 0, NULL, NULL);
        args[i] = next;
        if (!WideCharToMultiByte(CP_UTF8, 0, wide[i], -1, next, bytes, NULL, NULL)) abort();
        next += bytes;
    }
    args[*count] = NULL;
    LocalFree(wide);
    return args;
}
#else
#define fwp_path_fopen(path, mode) fopen(STR(path)->d, mode)
#endif

/* Native Windows resources. The language uses UTF-8 and binary streams. */
#ifdef _WIN32
static V fwp_win_io_error(const char *kind, const char *path, DWORD error, const fwp_desc *desc) {
    const char *message;
    char text[768], full[1024];
    switch (error) {
    case ERROR_FILE_NOT_FOUND: case ERROR_PATH_NOT_FOUND: case ERROR_INVALID_DRIVE:
        message = "No such file or directory"; break;
    case ERROR_ACCESS_DENIED: case ERROR_SHARING_VIOLATION: case ERROR_LOCK_VIOLATION:
        message = "Permission denied"; break;
    case ERROR_FILE_EXISTS: case ERROR_ALREADY_EXISTS: message = "File exists"; break;
    case ERROR_DIR_NOT_EMPTY: message = "Directory not empty"; break;
    case ERROR_DIRECTORY: message = "Not a directory"; break;
    case ERROR_BROKEN_PIPE: message = "Broken pipe"; break;
    default: {
        wchar_t wide[768];
        DWORD n = FormatMessageW(FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
                                NULL, error, 0, wide, 768, NULL);
        while (n && (wide[n - 1] == L'\r' || wide[n - 1] == L'\n')) wide[--n] = 0;
        if (!n || !WideCharToMultiByte(CP_UTF8, 0, wide, -1, text, sizeof text, NULL, NULL))
            snprintf(text, sizeof text, "Windows error %lu", (unsigned long)error);
        message = text;
    }
    }
    if (path) { snprintf(full, sizeof full, "%s: %s", path, message); message = full; }
    return fwp_io_error(kind, message, desc);
}

static DWORD fwp_win_attributes(V path) {
    fwp_win_text wide;
    if (!fwp_win_text_init(&wide, STR(path)->d, STR(path)->len)) return INVALID_FILE_ATTRIBUTES;
    HANDLE file = CreateFileW(wide.text, FILE_READ_ATTRIBUTES, FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
                              NULL, OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
    DWORD attributes = INVALID_FILE_ATTRIBUTES;
    if (file != INVALID_HANDLE_VALUE) {
        FILE_BASIC_INFO info;
        if (GetFileInformationByHandleEx(file, FileBasicInfo, &info, sizeof info)) attributes = info.FileAttributes;
        CloseHandle(file);
    }
    fwp_win_text_finish(&wide);
    return attributes;
}
static V fwp_p_file_exists(V path) {
    return fwp_win_attributes(path) == INVALID_FILE_ATTRIBUTES ? FWP_FALSE : FWP_TRUE;
}
static V fwp_p_file_is_dir(V path) {
    DWORD attributes = fwp_win_attributes(path);
    return attributes != INVALID_FILE_ATTRIBUTES && (attributes & FILE_ATTRIBUTE_DIRECTORY) ? FWP_TRUE : FWP_FALSE;
}
static V fwp_p_file_info(V path, const fwp_desc *error) {
    if (fwp_path_has_nul(path)) return fwp_io_error("stat", "path contains a NUL character", error);
    fwp_win_text wide;
    if (!fwp_win_text_init(&wide, STR(path)->d, STR(path)->len)) return fwp_io_error_path("stat", STR(path)->d, error);
    HANDLE file = CreateFileW(wide.text, FILE_READ_ATTRIBUTES, FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
                              NULL, OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
    DWORD failed = file == INVALID_HANDLE_VALUE ? GetLastError() : 0;
    fwp_win_text_finish(&wide);
    if (failed) return fwp_win_io_error("stat", STR(path)->d, failed, error);
    FILE_BASIC_INFO basic;
    FILE_STANDARD_INFO standard;
    if (!GetFileInformationByHandleEx(file, FileBasicInfo, &basic, sizeof basic) ||
        !GetFileInformationByHandleEx(file, FileStandardInfo, &standard, sizeof standard)) failed = GetLastError();
    CloseHandle(file);
    if (failed) return fwp_win_io_error("stat", STR(path)->d, failed, error);
    i128 modified = ((i128)basic.LastWriteTime.QuadPart - UINT64_C(116444736000000000)) * 100;
    if (modified < 0) modified = 0; /* interpreter metadata before Unix epoch */
    fwp_value_owner time = {fwp_rc_fresh(fwp_duration((int64_t)modified)), fwp_rc_free_obj};
    fwp_cleanup cleanup;
    fwp_value_protect(&time, &cleanup);
    V fields[3] = {standard.Directory ? FWP_TRUE : FWP_FALSE,
                   time.value, (V)standard.EndOfFile.QuadPart};
    V result = fwp_rc_fresh(fwp_record(3, fields));
    (void)fwp_value_finish(&time, &cleanup);

    return result;
}
static V fwp_win_remove(V path, int directory, const fwp_desc *error) {
    if (fwp_path_has_nul(path)) return fwp_io_error("remove", "path contains a NUL character", error);
    fwp_win_text wide;
    if (!fwp_win_text_init(&wide, STR(path)->d, STR(path)->len)) return fwp_io_error_path("remove", STR(path)->d, error);
    int ok = directory ? RemoveDirectoryW(wide.text) : DeleteFileW(wide.text);
    DWORD failed = ok ? 0 : GetLastError();
    fwp_win_text_finish(&wide);
    return failed ? fwp_win_io_error("remove", STR(path)->d, failed, error) : FWP_UNIT;
}
static V fwp_p_file_remove(V path, const fwp_desc *error) { return fwp_win_remove(path, 0, error); }
static V fwp_p_dir_remove(V path, const fwp_desc *error) { return fwp_win_remove(path, 1, error); }
static V fwp_p_file_rename(V to, V from, const fwp_desc *error) {
    if (fwp_path_has_nul(from) || fwp_path_has_nul(to)) return fwp_io_error("rename", "path contains a NUL character", error);
    fwp_win_text source, destination;
    if (!fwp_win_text_init(&source, STR(from)->d, STR(from)->len)) return fwp_io_error_path("rename", STR(from)->d, error);
    if (!fwp_win_text_init(&destination, STR(to)->d, STR(to)->len)) {
        int saved = errno; fwp_win_text_finish(&source); errno = saved;
        return fwp_io_error_path("rename", STR(from)->d, error);
    }
    DWORD failed = MoveFileExW(source.text, destination.text, MOVEFILE_REPLACE_EXISTING) ? 0 : GetLastError();
    fwp_win_text_finish(&source);
    fwp_win_text_finish(&destination);
    return failed ? fwp_win_io_error("rename", STR(from)->d, failed, error) : FWP_UNIT;
}
static void fwp_win_find_finish(void *pointer) {
    HANDLE *handle = (HANDLE *)pointer;
    if (*handle != INVALID_HANDLE_VALUE) FindClose(*handle);
    *handle = INVALID_HANDLE_VALUE;
}
static V fwp_p_dir_list(V path, const fwp_desc *error, void (*drop_list)(V)) {
    if (fwp_path_has_nul(path)) return fwp_io_error("list", "path contains a NUL character", error);
    fwp_win_text wide;
    if (!fwp_win_text_init(&wide, STR(path)->d, STR(path)->len)) return fwp_io_error_path("list", STR(path)->d, error);
    DWORD attributes = GetFileAttributesW(wide.text), failed = 0;
    if (attributes == INVALID_FILE_ATTRIBUTES) failed = GetLastError();
    else if (!(attributes & FILE_ATTRIBUTE_DIRECTORY)) failed = ERROR_DIRECTORY;
    if (failed) { fwp_win_text_finish(&wide); return fwp_win_io_error("list", STR(path)->d, failed, error); }
    size_t size = wcslen(wide.text);
    wchar_t *pattern = (wchar_t *)malloc((size + 3) * sizeof *pattern);
    if (!pattern) { fwp_win_text_finish(&wide); fwp_trap("out of memory listing directory"); }
    memcpy(pattern, wide.text, size * sizeof *pattern);
    pattern[size++] = L'\\'; pattern[size++] = L'*'; pattern[size] = 0;
    fwp_win_text_finish(&wide);
    WIN32_FIND_DATAW entry;
    HANDLE handle = FindFirstFileW(pattern, &entry);
    failed = handle == INVALID_HANDLE_VALUE ? GetLastError() : 0;
    free(pattern);
    if (failed == ERROR_FILE_NOT_FOUND) return 0;
    if (failed) return fwp_win_io_error("list", STR(path)->d, failed, error);
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_win_find_finish, &handle);
    fwp_map_owner owner={NULL,0,0,fwp_rc_free_obj,drop_list};
    fwp_cleanup owner_cleanup;fwp_map_protect(&owner,&owner_cleanup);
    size_t capacity=16;owner.items=(V *)fwp_mem_alloc(capacity*sizeof(V));
    do {
        if (!wcscmp(entry.cFileName, L".") || !wcscmp(entry.cFileName, L"..")) continue;
        if (owner.count == capacity) {
            size_t old = capacity;
            if (old > SIZE_MAX / 2 / sizeof(V)) fwp_trap("directory too large");
            capacity *= 2;
            owner.items = (V *)fwp_mem_realloc(owner.items, old * sizeof(V), capacity * sizeof(V));
        }
        owner.items[owner.count]=fwp_rc_fresh(fwp_win_string(entry.cFileName,wcslen(entry.cFileName)));
        owner.count++;
    } while (FindNextFileW(handle, &entry));
    failed = GetLastError();
    if (failed != ERROR_NO_MORE_FILES) return fwp_win_io_error("list",STR(path)->d,failed,error);
    qsort(owner.items,owner.count,sizeof(V),fwp_cmp_cstr);
    V result=fwp_map_finish_protected(&owner,&owner_cleanup);
    fwp_cleanup_pop(&cleanup);fwp_win_find_finish(&handle);
    return result;
}
static V fwp_p_dir_create(V path, const fwp_desc *error) {
    if (fwp_path_has_nul(path)) return fwp_io_error("create", "path contains a NUL character", error);
    fwp_win_text wide;
    if (!fwp_win_text_init(&wide, STR(path)->d, STR(path)->len)) return fwp_io_error_path("create", STR(path)->d, error);
    DWORD failed = CreateDirectoryW(wide.text, NULL) ? 0 : GetLastError();
    fwp_win_text_finish(&wide);
    return failed ? fwp_win_io_error("create", STR(path)->d, failed, error) : FWP_UNIT;
}
static V fwp_p_dir_create_all(V path, const fwp_desc *error) {
    if (fwp_path_has_nul(path)) return fwp_io_error("create", "path contains a NUL character", error);
    fwp_win_text wide;
    if (!fwp_win_text_init(&wide, STR(path)->d, STR(path)->len)) return fwp_io_error_path("create", STR(path)->d, error);
    wchar_t *p = wide.text;
    size_t length = wcslen(p), start = 1;
    if (length >= 2 && p[1] == L':') start = 3;
    else if (length >= 2 && (p[0] == L'\\' || p[0] == L'/') && p[1] == p[0]) {
        // A UNC server/share is a root, never a directory to create.
        start = 2;
        for (int component = 0; component < 2; component++) {
            while (start < length && p[start] != L'\\' && p[start] != L'/') start++;
            if (start < length) start++;
        }
    }
    DWORD failed = 0;
    for (size_t i = start; i <= length; i++) {
        if (i < length && p[i] != L'\\' && p[i] != L'/') continue;
        wchar_t saved = p[i]; p[i] = 0;
        DWORD attributes = GetFileAttributesW(p);
        if (attributes == INVALID_FILE_ATTRIBUTES || !(attributes & FILE_ATTRIBUTE_DIRECTORY)) {
            if (!CreateDirectoryW(p, NULL)) {
                failed = GetLastError();
                attributes = GetFileAttributesW(p);
                if (failed == ERROR_ALREADY_EXISTS && attributes != INVALID_FILE_ATTRIBUTES &&
                    (attributes & FILE_ATTRIBUTE_DIRECTORY)) failed = 0;
            }
        }
        p[i] = saved;
        if (failed) break;
    }
    fwp_win_text_finish(&wide);
    return failed ? fwp_win_io_error("create", STR(path)->d, failed, error) : FWP_UNIT;
}
static void fwp_win_environment_finish(void *environment) { FreeEnvironmentStringsW((wchar_t *)environment); }
static V fwp_p_env_vars(void (*drop_pair)(V), void (*drop_list)(V)) {
    wchar_t *environment=GetEnvironmentStringsW();
    if(!environment)fwp_trap("cannot read process environment");
    fwp_cleanup environment_cleanup;
    fwp_cleanup_push(&environment_cleanup,fwp_win_environment_finish,environment);
    fwp_map_owner owner={NULL,0,0,drop_pair,drop_list};
    fwp_cleanup cleanup;fwp_map_protect(&owner,&cleanup);
    size_t capacity=16;owner.items=(V *)fwp_mem_alloc(capacity*sizeof(V));
    for(const wchar_t *p=environment;*p;p+=wcslen(p)+1) {
        if(*p==L'=')continue;
        const wchar_t *equal=wcschr(p,L'=');if(!equal)continue;
        if(owner.count==capacity) {
            if(capacity>SIZE_MAX/sizeof(V)/2)fwp_trap("environment too large");
            owner.items=fwp_mem_realloc(owner.items,capacity*sizeof(V),capacity*2*sizeof(V));
            capacity*=2;
        }
        fwp_value_owner key={fwp_rc_fresh(fwp_win_string(p,(size_t)(equal-p))),fwp_rc_free_obj};
        fwp_cleanup key_cleanup;fwp_value_protect(&key,&key_cleanup);
        fwp_value_owner value={fwp_rc_fresh(fwp_win_string(equal+1,wcslen(equal+1))),fwp_rc_free_obj};
        fwp_cleanup value_cleanup;fwp_value_protect(&value,&value_cleanup);
        owner.items[owner.count]=fwp_rc_fresh(fwp_record(2,(V[]){key.value,value.value}));
        owner.count++;
        (void)fwp_value_finish(&value,&value_cleanup);
        (void)fwp_value_finish(&key,&key_cleanup);
    }
    qsort(owner.items,owner.count,sizeof(V),fwp_cmp_env);
    V result=fwp_map_finish_protected(&owner,&cleanup);
    fwp_cleanup_pop(&environment_cleanup);FreeEnvironmentStringsW(environment);
    return result;
}
static V fwp_p_env_cwd(const fwp_desc *error) {
    DWORD size = GetCurrentDirectoryW(0, NULL);
    if (!size) return fwp_win_io_error("cwd", NULL, GetLastError(), error);
    wchar_t *path = (wchar_t *)malloc((size_t)size * sizeof *path);
    if (!path) fwp_trap("out of memory reading working directory");
    DWORD got = GetCurrentDirectoryW(size, path);
    if (!got || got >= size) {
        DWORD failed = got ? ERROR_INSUFFICIENT_BUFFER : GetLastError();
        free(path);
        return fwp_win_io_error("cwd", NULL, failed, error);
    }
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_win_free, path);
    V result = fwp_win_string(path, got);
    fwp_cleanup_pop(&cleanup);
    free(path);
    return result;
}
static V fwp_p_term_is_tty(V fd) {
    if ((int64_t)fd < 0 || fd > 2) return FWP_FALSE;
    fwp_flush();
    DWORD mode;
    return GetConsoleMode((HANDLE)_get_osfhandle((int)fd), &mode) ? FWP_TRUE : FWP_FALSE;
}
static V fwp_p_term_width(void) {
    const char *columns = getenv("COLUMNS");
    if (columns && *columns && strlen(columns) <= 5 && strspn(columns, "0123456789") == strlen(columns)) {
        long width = strtol(columns, NULL, 10);
        if (width > 0) return (V)width;
    }
    const int streams[3] = {1, 2, 0};
    for (int i = 0; i < 3; i++) {
        CONSOLE_SCREEN_BUFFER_INFO info;
        if (GetConsoleScreenBufferInfo((HANDLE)_get_osfhandle(streams[i]), &info))
            return (V)(info.srWindow.Right - info.srWindow.Left + 1);
    }
    return 80; /* same explicit terminal-width contract as the interpreter */
}
typedef struct { HANDLE handle; DWORD mode; int changed; } fwp_win_console;
static void fwp_win_console_restore(void *pointer) {
    fwp_win_console *console = (fwp_win_console *)pointer;
    if (console->changed) SetConsoleMode(console->handle, console->mode);
}
static V fwp_p_term_read_secret(void) {
    fwp_flush(); fflush(stderr);
    fwp_win_console console = {(HANDLE)_get_osfhandle(0), 0, 0};
    if (GetConsoleMode(console.handle, &console.mode))
        console.changed = SetConsoleMode(console.handle, console.mode & ~ENABLE_ECHO_INPUT);
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_win_console_restore, &console);
    V result = fwp_p_read_line();
    fwp_cleanup_pop(&cleanup);
    fwp_win_console_restore(&console);
    if (console.changed) fputc('\n', stderr);
    return result;
}

typedef struct { HANDLE handle; char *data; size_t size, capacity; DWORD error; } fwp_win_process_output;
static DWORD WINAPI fwp_win_process_read(void *pointer) {
    fwp_win_process_output *output = (fwp_win_process_output *)pointer;
    char bytes[65536];
    for (;;) {
        DWORD count;
        if (!ReadFile(output->handle, bytes, sizeof bytes, &count, NULL)) {
            DWORD error = GetLastError();
            if (error != ERROR_BROKEN_PIPE) output->error = error;
            break;
        }
        if (!count) break;
        if ((size_t)count > SIZE_MAX - output->size) { output->error = ERROR_NOT_ENOUGH_MEMORY; break; }
        size_t required = output->size + count;
        if (required > output->capacity) {
            size_t capacity = output->capacity ? output->capacity : 65536;
            while (capacity < required && capacity <= SIZE_MAX / 2) capacity *= 2;
            if (capacity < required) capacity = required;
            char *grown = (char *)realloc(output->data, capacity);
            if (!grown) { output->error = ERROR_NOT_ENOUGH_MEMORY; break; }
            output->data = grown; output->capacity = capacity;
        }
        memcpy(output->data + output->size, bytes, count);
        output->size += count;
    }
    CloseHandle(output->handle);
    output->handle = NULL;
    return 0;
}
typedef struct {
    PROCESS_INFORMATION process;
    HANDLE input, inherited[3];
#ifdef FWP_STATIC_MEMORY
    fwp_static_worker *readers[2];
#else
    HANDLE readers[2];
#endif
    fwp_win_process_output output[2];
    LPPROC_THREAD_ATTRIBUTE_LIST attributes;
    int attributes_initialized;
} fwp_win_process;
static void fwp_win_process_finish(void *pointer) {
    fwp_win_process *process = (fwp_win_process *)pointer;
    if (process->process.hProcess && WaitForSingleObject(process->process.hProcess, 0) == WAIT_TIMEOUT) {
        TerminateProcess(process->process.hProcess, 1);
        WaitForSingleObject(process->process.hProcess, INFINITE);
    }
    fwp_win_close(&process->input);
    for (int i = 0; i < 3; i++) fwp_win_close(&process->inherited[i]);
    for (int i = 0; i < 2; i++) {
        if (process->readers[i]) {
#ifdef FWP_STATIC_MEMORY
            fwp_static_worker_release(process->readers[i]);
#else
            WaitForSingleObject(process->readers[i], INFINITE);
            CloseHandle(process->readers[i]);
#endif
        } else fwp_win_close(&process->output[i].handle);
        free(process->output[i].data);
    }
    if (process->attributes_initialized) DeleteProcThreadAttributeList(process->attributes);
    free(process->attributes);
    fwp_win_close(&process->process.hThread);
    fwp_win_close(&process->process.hProcess);
    memset(process, 0, sizeof *process);
}

/* CRT argv quoting, including empty arguments, quotes and trailing slashes.
 * CreateProcessW's command line is explicitly bounded to 32767 UTF-16 units. */
static int fwp_win_quote(wchar_t *command, size_t *used, const wchar_t *argument) {
    size_t n = *used;
#define FWP_COMMAND_CHAR(c) do { if (n >= 32766) return 0; command[n++] = (c); } while (0)
    if (n) FWP_COMMAND_CHAR(L' ');
    FWP_COMMAND_CHAR(L'"');
    for (const wchar_t *p = argument;;) {
        size_t slashes = 0;
        while (*p == L'\\') { slashes++; p++; }
        size_t escaped = (*p == L'"' || !*p) ? slashes * 2 : slashes;
        for (size_t i = 0; i < escaped; i++) FWP_COMMAND_CHAR(L'\\');
        if (!*p) break;
        if (*p == L'"') FWP_COMMAND_CHAR(L'\\');
        FWP_COMMAND_CHAR(*p++);
    }
    FWP_COMMAND_CHAR(L'"');
    command[n] = 0; *used = n;
#undef FWP_COMMAND_CHAR
    return 1;
}
static V fwp_run_process(V argv, V input, int capture, const fwp_desc *error) {
    if (!argv) return fwp_io_error("spawn", "empty command", error);
    for (V list = argv; list; list = OBJ(list)->f[1])
        if (fwp_path_has_nul(OBJ(list)->f[0]))
            return fwp_io_error("spawn", "command argument contains a NUL character", error);
    V program = OBJ(argv)->f[0];
    wchar_t command[32768];
    size_t used = 0;
    for (V list = argv; list; list = OBJ(list)->f[1]) {
        V argument = OBJ(list)->f[0];
        fwp_win_text wide;
        if (!fwp_win_text_init(&wide, STR(argument)->d, STR(argument)->len))
            return fwp_io_error_path("spawn", STR(program)->d, error);
        int ok = fwp_win_quote(command, &used, wide.text);
        fwp_win_text_finish(&wide);
        if (!ok) return fwp_io_error("spawn", "command line exceeds Windows limit", error);
    }
    fwp_flush(); fflush(stderr);
    fwp_win_process process = {0};
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_win_process_finish, &process);
    DWORD failed = 0;
    SECURITY_ATTRIBUTES security = {sizeof security, NULL, TRUE};
    STARTUPINFOEXW startup = {0};
    startup.StartupInfo.cb = sizeof startup;
    startup.StartupInfo.dwFlags = STARTF_USESTDHANDLES;
    if (capture) {
        if (!CreatePipe(&process.inherited[0], &process.input, &security, 0) ||
            !CreatePipe(&process.output[0].handle, &process.inherited[1], &security, 0) ||
            !CreatePipe(&process.output[1].handle, &process.inherited[2], &security, 0)) {
            failed = GetLastError(); goto finish;
        }
    } else {
        const int streams[3] = {0, fwp_prog_out == stderr ? 2 : 1, 2};
        for (int i = 0; i < 3; i++) {
            HANDLE handle = (HANDLE)_get_osfhandle(streams[i]);
            if (handle == INVALID_HANDLE_VALUE || !handle) continue;
            if (!DuplicateHandle(GetCurrentProcess(), handle, GetCurrentProcess(),
                                 &process.inherited[i], 0, TRUE, DUPLICATE_SAME_ACCESS)) {
                failed = GetLastError(); goto finish;
            }
        }
    }
    startup.StartupInfo.hStdInput = process.inherited[0];
    startup.StartupInfo.hStdOutput = process.inherited[1];
    startup.StartupInfo.hStdError = process.inherited[2];
    HANDLE inherited[3];
    size_t inherited_count = 0;
    for (int i = 0; i < 3; i++) if (process.inherited[i]) inherited[inherited_count++] = process.inherited[i];
    DWORD flags = CREATE_SUSPENDED;
    if (inherited_count) {
        SIZE_T size = 0;
        InitializeProcThreadAttributeList(NULL, 1, 0, &size);
        process.attributes = (LPPROC_THREAD_ATTRIBUTE_LIST)malloc(size);
        if (!process.attributes) { failed = ERROR_NOT_ENOUGH_MEMORY; goto finish; }
        if (!InitializeProcThreadAttributeList(process.attributes, 1, 0, &size)) { failed = GetLastError(); goto finish; }
        process.attributes_initialized = 1;
        if (!UpdateProcThreadAttribute(process.attributes, 0, PROC_THREAD_ATTRIBUTE_HANDLE_LIST,
                                       inherited, inherited_count * sizeof(HANDLE), NULL, NULL)) {
            failed = GetLastError(); goto finish;
        }
        startup.lpAttributeList = process.attributes;
        flags |= EXTENDED_STARTUPINFO_PRESENT;
    } else startup.StartupInfo.cb = sizeof(STARTUPINFOW);
    if (!CreateProcessW(NULL, command, NULL, NULL, inherited_count != 0, flags, NULL, NULL,
                        &startup.StartupInfo, &process.process)) { failed = GetLastError(); goto finish; }
    // Only the listed child endpoints are inherited. Closing the parent's
    // copies ensures reader threads can observe EOF after the child exits.
    for (int i = 0; i < 3; i++) fwp_win_close(&process.inherited[i]);
    if (capture) {
        for (int i = 0; i < 2; i++) {
#ifdef FWP_STATIC_MEMORY
            process.readers[i] = fwp_static_worker_start(fwp_win_process_read, &process.output[i]);
#else
            process.readers[i] = CreateThread(NULL, 0, fwp_win_process_read, &process.output[i], 0, NULL);
            if (!process.readers[i]) { failed = GetLastError(); goto finish; }
#endif
        }
    }
    if (ResumeThread(process.process.hThread) == (DWORD)-1) { failed = GetLastError(); goto finish; }
    if (capture) {
        size_t offset = 0;
        while (offset < STR(input)->len) {
            size_t remaining = STR(input)->len - offset;
            DWORD written, amount = remaining > 65536 ? 65536 : (DWORD)remaining;
            if (!WriteFile(process.input, STR(input)->d + offset, amount, &written, NULL)) {
                DWORD code = GetLastError();
                if (code != ERROR_BROKEN_PIPE && code != ERROR_NO_DATA) failed = code;
                break;
            }
            if (!written) { failed = ERROR_WRITE_FAULT; break; }
            offset += written;
        }
        fwp_win_close(&process.input);
    }
    if (failed) goto finish;
    if (WaitForSingleObject(process.process.hProcess, INFINITE) != WAIT_OBJECT_0) { failed = GetLastError(); goto finish; }
    if (capture) for (int i = 0; i < 2; i++) {
#ifdef FWP_STATIC_MEMORY
        fwp_static_worker_wait(process.readers[i]);
#else
        if (WaitForSingleObject(process.readers[i], INFINITE) != WAIT_OBJECT_0) { failed = GetLastError(); goto finish; }
#endif
        if (process.output[i].error) { failed = process.output[i].error; goto finish; }
    }
    DWORD code;
    if (!GetExitCodeProcess(process.process.hProcess, &code)) { failed = GetLastError(); goto finish; }
    V result = (V)(int64_t)(int32_t)code;
    if (capture) {
        fwp_value_owner stderr_value = {fwp_rc_fresh(fwp_str_lossy(process.output[1].data ? process.output[1].data : "", process.output[1].size)), fwp_rc_free_obj};
        fwp_cleanup stderr_cleanup; fwp_value_protect(&stderr_value, &stderr_cleanup);
        fwp_value_owner stdout_value = {fwp_rc_fresh(fwp_str_lossy(process.output[0].data ? process.output[0].data : "", process.output[0].size)), fwp_rc_free_obj};
        fwp_cleanup stdout_cleanup; fwp_value_protect(&stdout_value, &stdout_cleanup);
        V fields[3] = {result, stderr_value.value, stdout_value.value};
        result = fwp_rc_fresh(fwp_record(3, fields));
        (void)fwp_value_finish(&stdout_value, &stdout_cleanup);
        (void)fwp_value_finish(&stderr_value, &stderr_cleanup);
    }
    fwp_cleanup_pop(&cleanup);
    fwp_win_process_finish(&process);

    return result;
finish:
    fwp_cleanup_pop(&cleanup);
    fwp_win_process_finish(&process);
    return fwp_win_io_error("spawn", STR(program)->d, failed, error);
}
static V fwp_p_process_run_input(V input, V argv, const fwp_desc *error) { return fwp_run_process(argv, input, 1, error); }
static V fwp_p_process_call(V argv, const fwp_desc *error) { return fwp_run_process(argv, 0, 0, error); }
#endif

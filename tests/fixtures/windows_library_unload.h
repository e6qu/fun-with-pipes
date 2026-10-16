#define _WIN32_WINNT 0x0a00
#include <winsock2.h>
#include <windows.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
struct snapshot {
 void *heap, *meta, *stacks[3], *fibers[3], *wide, *fins, *marks, *metrics, *name;
 uintptr_t socket;
 int entered, completed, cancelled, finalized, order_error, static_exit;
 int wide_freed, fins_freed, marks_freed, metrics_freed, name_freed;
 int fibers_deleted, key_deleted, signal_added, signal_removed, finished;
};

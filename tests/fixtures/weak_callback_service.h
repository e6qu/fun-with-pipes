#ifndef WEAK_CALLBACK_SERVICE_H
#define WEAK_CALLBACK_SERVICE_H
#include <stddef.h>
#include <stdint.h>
typedef struct { int64_t calls, cancelled, expired, errors, sent, received, sum, received_sum; } ServiceStats;
ServiceStats service_run(size_t population, int mode);
#endif

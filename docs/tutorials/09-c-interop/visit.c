#include <stdint.h>
int64_t visit(int64_t (*callback)(const char *)) {
    return callback("hello");
}

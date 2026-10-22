#include <stdint.h>
/* The reference interpreter executes the same program without measurement. */
void file_app_checkpoint(int64_t phase, int64_t remaining) {
    (void)phase;
    (void)remaining;
}

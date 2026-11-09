/* Diagnostic checkpoints only; ordinary memory runs do not link this helper. */
#include <signal.h>
#include <stddef.h>
#include <unistd.h>

void parser_memory_checkpoint(unsigned phase) {
    static const char messages[][3] = {"0\n", "1\n", "2\n", "3\n", "4\n"};
    if (phase >= sizeof(messages) / sizeof(messages[0])) _exit(90);
    if (write(STDOUT_FILENO, messages[phase], 2) != 2 || raise(SIGSTOP)) _exit(90);
    char reply;
    if (read(STDIN_FILENO, &reply, 1) != 1 || reply != '\n') _exit(90);
}

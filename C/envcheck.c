#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void run_env_check(void) __attribute__((constructor));


const char* message = "You must run this executable with the `asanlog` binary. For example: `asanlog ./test`.\n";
void run_env_check(void) {
    if (getenv("ASANLOG_ENABLED") == NULL || strcmp(getenv("ASANLOG_ENABLED"), "true") != 0) {
        fprintf(stderr, message);
        exit(125);
    }
    if (getenv("ASAN_OPTIONS") == NULL) {
        fprintf(stderr, message);
        exit(126);
    }
}
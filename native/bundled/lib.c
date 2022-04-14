#include "lib.h"
#include "stdlib.h"

struct libtest_foo *libtest_new_foo() {
    struct libtest_foo *new = calloc(1, sizeof(struct libtest_foo));
    return new;
}

void libtest_set_bar(struct libtest_foo *f, struct libtest_bar b) {
    f->b = b;
    return;
}

void libtest_set_callback(struct libtest_foo *f, libtest_callback *cb) {
    f->on_connection_complete = cb;
}

void libtest_run(struct libtest_foo *f) {
    f->on_connection_complete(&(f->b));
    return;
}

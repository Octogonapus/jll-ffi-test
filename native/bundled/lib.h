struct libtest_bar {
    int f1;
};

typedef void (libtest_callback)(struct libtest_bar *b);

struct libtest_foo {
    libtest_callback *on_connection_complete;
    struct libtest_bar b;
};

struct libtest_foo *libtest_new_foo();

void libtest_set_bar(struct libtest_foo *f, struct libtest_bar b);

void libtest_set_callback(struct libtest_foo *f, libtest_callback *cb);

void libtest_run(struct libtest_foo *f);

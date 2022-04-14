module LibTest

using libtest_jll
export libtest_jll

using CEnum

struct libtest_bar
    f1::Cint
end

# typedef void ( libtest_callback ) ( struct libtest_bar * b )
const libtest_callback = Cvoid

struct libtest_foo
    on_connection_complete::Ptr{Cvoid}
    b::libtest_bar
end

# no prototype is found for this function at lib.h:12:21, please use with caution
"""
    libtest_new_foo()

### Prototype
```c
struct libtest_foo *libtest_new_foo();
```
"""
function libtest_new_foo()
    ccall((:libtest_new_foo, libtest), Ptr{libtest_foo}, ())
end

"""
    libtest_set_bar(f, b)

### Prototype
```c
void libtest_set_bar(struct libtest_foo *f, struct libtest_bar b);
```
"""
function libtest_set_bar(f, b)
    ccall((:libtest_set_bar, libtest), Cvoid, (Ptr{libtest_foo}, libtest_bar), f, b)
end

"""
    libtest_set_callback(f, cb)

### Prototype
```c
void libtest_set_callback(struct libtest_foo *f, libtest_callback *cb);
```
"""
function libtest_set_callback(f, cb)
    ccall((:libtest_set_callback, libtest), Cvoid, (Ptr{libtest_foo}, Ptr{Cvoid}), f, cb)
end

"""
    libtest_run(f)

### Prototype
```c
void libtest_run(struct libtest_foo *f);
```
"""
function libtest_run(f)
    ccall((:libtest_run, libtest), Cvoid, (Ptr{libtest_foo},), f)
end

# exports
const PREFIXES = ["libtest_"]
for name in names(@__MODULE__; all=true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end

end # module

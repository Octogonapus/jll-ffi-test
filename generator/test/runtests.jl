using Test
using LibTest

function callback(bar)
    @show bar
    return nothing
end

function runtest()
    foo = libtest_new_foo()
    bar = libtest_bar(1)
    libtest_set_bar(foo, bar)
    callback_cb = @cfunction(callback, Cvoid, (Ptr{libtest_bar},))
    libtest_set_callback(foo, callback_cb)
    libtest_run(foo)
end

@testset "ts" begin
    runtest()
end

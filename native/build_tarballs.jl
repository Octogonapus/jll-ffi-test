# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder, Pkg

name = "libtest"
version = v"0.1.0"

# Collection of sources required to complete build
sources = [
    DirectorySource("./bundled"),
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
gcc -c -fpic lib.c
gcc -shared -o libtest.so lib.o
mkdir -p $WORKSPACE/destdir/lib64
mkdir -p $WORKSPACE/destdir/include
cp libtest.so $WORKSPACE/destdir/lib64/
cp lib.h $WORKSPACE/destdir/include
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = supported_platforms()

# The products that we will ensure are always built
products = [
    LibraryProduct("libtest", :libtest),
]

# Dependencies that must be installed before this package can be built
dependencies = [
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies; julia_compat="1.6", preferred_gcc_version = v"10.2.0")

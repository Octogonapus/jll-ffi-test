using Clang.Generators
# using Clang.LibClang.Clang_jll  # replace this with your jll package
using libtest_jll

cd(@__DIR__)

include_dir = normpath(libtest_jll.artifact_dir, "include")

options = load_options(joinpath(@__DIR__, "generator.toml"))

# add compiler flags, e.g. "-DXXXXXXXXX"
args = get_default_args()  # Note you must call this function firstly and then append your own flags
push!(args, "-I$include_dir")

header_dirs = vcat([
    readdir(joinpath(include_dir); join = true),
]...)
headers = [header for header in header_dirs if endswith(header, ".h")]
# there is also an experimental `detect_headers` function for auto-detecting top-level headers in the directory
# headers = detect_headers(include_dir, args)

# create context
ctx = create_context(headers, args, options)

# run generator
build!(ctx)

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "zserio_bin",
    url = "https://github.com/ndsev/zserio/releases/download/v2.7.0/zserio-2.7.0-bin.zip",
    sha256 = "00010c4b98603e57832c27bde230638402c350de023b0ba5f370f72bff91c55d",
    build_file = "//zserio:zserio_bin.BUILD"
)

http_archive(
    name = "zserio_runtime",
    url = "https://github.com/ndsev/zserio/releases/download/v2.7.0/zserio-2.7.0-runtime-libs.zip",
    sha256 = "7501a49c8ebcf77b551c64ae21696f76c578b7b78396bb35dc453bf6a1020294",
    strip_prefix = "runtime_libs/cpp",
    build_file = "//zserio:zserio_runtime.BUILD"
)

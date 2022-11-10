
cc_binary(
    name = "demo",
    # srcs = glob(["**/*.cpp", "**/*.h"]) + ["//zserio:base"],
    srcs = ["main.cpp", "data/Vector.h", "data/Data.cpp", "//zserio:base"],
    copts = [
        "-I.",
        # "-Izserio"
    ],
    includes = [
        "base"
    ],
    deps = [
        "@zserio_runtime",
    ],
    # visibility = ["//visibility:public"]
)

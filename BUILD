
cc_binary(
    name = "demo",
    srcs = ["main.cpp", "//base:Point.h", "//base:Base.cpp", "//data:Vector.h", "//data:Data.cpp"],
    copts = [
        "-I.",
        # "-Ibase",
    #     "-Idata"
    ],
    deps = [
        "@zserio_runtime"
    ]
)

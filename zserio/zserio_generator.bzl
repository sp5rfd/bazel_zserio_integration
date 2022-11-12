def input_files():
    return [
        "base.zs",
        "data.zs"
    ]

def expected_outputs_base():
    return [
        "_/base/Base.cpp",
        "_/base/Point.h"
    ]

def expected_outputs_data():
    return [
        "_/data/Data.cpp",
        "_/data/Vector.h"
    ]

def expected_outputs():
    return expected_outputs_base() + expected_outputs_data()

def _impl(ctx):
    java = ctx.attr._jdk[java_common.JavaRuntimeInfo]

    # inputs
    zserio_jar = ctx.file._zserio_jar
    ins = [ 
        zserio_jar,
    ] + ctx.files._jdk + ctx.files.input_files

    # outputs
    cpp_dir = ctx.actions.declare_directory("./_")  # dig more here
    outs = [
        cpp_dir,
    ] + ctx.outputs.outputs_base + ctx.outputs.outputs_data

    # other params
    src_dir = "zserio"

    ctx.actions.run_shell(
        inputs = ins,
        outputs = outs,
        command = """
            for name in base.zs data.zs 
            do
                {java} -jar {zserio} -cpp {cpp_dir} -src {src_dir} $name
            done
        """.format(
            java = java.java_executable_exec_path,
            zserio = zserio_jar.path,
            cpp_dir = cpp_dir.path,
            src_dir = src_dir,
        )
    )

    return [
        DefaultInfo(files = depset(outs)),
        CcInfo()
    ]


zserio_codegen = rule(
    implementation = _impl,
    attrs = {
        "_jdk": attr.label(
            default = Label("@bazel_tools//tools/jdk:current_host_java_runtime"),
            providers = [java_common.JavaRuntimeInfo],
        ),
        "_zserio_jar": attr.label(
            default = Label("@zserio_bin"),
            allow_single_file = True
        ),
        "input_files": attr.label_list(
            default = input_files(),
            allow_files = True
        ),

        # "output_files": attr.output_list(),
        "outputs_base": attr.output_list(),
        "outputs_data": attr.output_list(),
    }
)


def create_model(name):
    # generate zSerio code
    zserio_codegen(
        name = name + "_",
        # output_files = expected_outputs(),
        outputs_base = expected_outputs_base(),
        outputs_data = expected_outputs_data(),
        visibility = ["//visibility:public"],
    )

    # compile library out of generated code
    native.cc_library(
        name = name,
        srcs = expected_outputs(),
        includes = [
            "_"
        ],
        deps = [
            "@zserio_runtime"
        ],
        visibility = ["//visibility:public"],
    )
    

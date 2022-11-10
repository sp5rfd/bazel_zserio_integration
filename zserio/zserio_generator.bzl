
def input_files():
    return [
        "base.zs",
        "data.zs"
    ]


def expected_outputs_base():
    return [
        "base/Base.cpp",
        "base/Point.h"
    ]


def expected_outputs_data():
    return [
        "data/Data.cpp",
        "data/Vector.h"
    ]
        

def _impl(ctx):
    name = ctx.attr.name
    java = ctx.attr._jdk[java_common.JavaRuntimeInfo]

    # inputs
    zserio_jar = ctx.file._zserio_jar
    zserio_template = ctx.file.zserio_template
    ins = [ 
        zserio_jar,
        zserio_template,
    ] + ctx.files._jdk + ctx.files.input_files

    # outputs
    cpp_dir = ctx.actions.declare_directory(".")
    outs = [
        cpp_dir,
    ] + ctx.outputs.output_files

    # other params
    src_dir = "zserio"

    ctx.actions.run_shell(
        inputs = ins,
        outputs = outs,
        command = """
            echo NAME: {name} JAVA: {java} , ZSERIO: {zserio}, CPP: {cpp_dir}, SRC: {src_dir}, ZS: {zserio_template},{name}.zs
            {java} -jar {zserio} -cpp {cpp_dir} -src {src_dir} {name}.zs
        """.format(
            name = name,
            java = java.java_executable_exec_path,
            zserio = zserio_jar.path,
            cpp_dir = cpp_dir.path,
            src_dir = src_dir,
            zserio_template = zserio_template.path
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
        "zserio_template": attr.label(
            allow_single_file = True
        ),
        "input_files": attr.label_list(
            default = input_files(),
            allow_files = True
        ),
        "output_files": attr.output_list()
    }
)


def create_model(name, output_files):
    # generate zSerio code
    zserio_codegen(
        name = name,
        zserio_template = name + ".zs",
        output_files = output_files,
        visibility = ["//visibility:public"],
    ) 
    
    # print("kompiluje libke")
 
    # native.cc_library(
    #     name = name,
    #     srcs = output_files,
    #     includes = [
    #         "."
    #     ],
    #     deps = [
    #         "@zserio_runtime"
    #     ],
    #     visibility = ["//visibility:public"],
    # )
    

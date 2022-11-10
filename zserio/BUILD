load("//zserio:zserio_generator.bzl", "create_model", "expected_outputs_base", "expected_outputs_data")

create_model(
    name = "base",
    output_files = expected_outputs_base()
)

create_model(
    name = "data",
    output_files = expected_outputs_data()
)

alias(
    name = "zserio_bin",
    actual = "@zserio_bin"
)

alias(
    name = "zserio_runtime",
    actual = "@zserio_runtime"
)

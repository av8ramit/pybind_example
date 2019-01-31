load("//module:py.bzl", "py_extension")

py_extension(
    name = "math",
    srcs = ["math.cc"],
    deps = [
        "//third_party/python_runtime:headers",
        "@pybind11",
    ],
)

py_test(
    name = "math_test",
    size = "small",
    srcs = ["math_test.py"],
    deps = [":math"],
)

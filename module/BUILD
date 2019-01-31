load("//module:py.bzl", "py_extension")

py_extension(
    name = "math",
    srcs = ["math.cc"],
    deps = ["@pybind11",
    "//third_party/python_runtime:headers"],
)

py_test(
    name = "math_test",
    size = "small",
    srcs = ["math_test.py"],
    deps = [":math"],
)

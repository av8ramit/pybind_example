load("//third_party:repo.bzl", "tf_http_archive")
load("//third_party/py:python_configure.bzl", "python_configure")

tf_http_archive(
    name = "pybind11",
    urls = [
        "https://mirror.bazel.build/github.com/pybind/pybind11/archive/v2.2.4.tar.gz",
        "https://github.com/pybind/pybind11/archive/v2.2.4.tar.gz",
    ],
    sha256 = "b69e83658513215b8d1443544d0549b7d231b9f201f6fc787a2b2218b408181e",
    strip_prefix = "pybind11-2.2.4",
    build_file = str("//third_party:pybind11.BUILD"),
)

python_configure(name = "local_config_python")
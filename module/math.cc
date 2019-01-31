#include <pybind11/pybind11.h>

int add(int i, int j) {
  return i + j;
}

namespace py = pybind11;

PYBIND11_MODULE(math, m) {
  m.doc() = R"pbdoc(
    math
    -----

    .. currentmodule:: math

       add
       subtract
  )pbdoc";

  m.attr("__version__") = "0.0.1";

  m.def("add", &add, R"pbdoc(
    Add two numbers.
  )pbdoc");

  m.def("subtract", [](int i, int j) { return i - j; }, R"pbdoc(
    Subtract two numbers.
  )pbdoc");
}
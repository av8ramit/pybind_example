# pybind_example
A simple math pybind11 example that exports C++ functions to Python with Bazel.

```bash
$ bazel test module:math_test
INFO: Invocation ID: d5cc2be5-db23-4850-9ebe-e7c4ff5818a8
INFO: Analysed target //module:math_test (23 packages loaded, 303 targets configured).
INFO: Found 1 test target...
Target //module:math_test up-to-date:
  bazel-bin/module/math_test
INFO: Elapsed time: 2.740s, Critical Path: 2.34s
INFO: 6 processes: 6 linux-sandbox.
INFO: Build completed successfully, 11 total actions
//module:math_test                                                       PASSED in 0.1s

INFO: Build completed successfully, 11 total actions
```

Special thanks to jart@ for guidance as well as the TensorFlow team for python runtime headers.

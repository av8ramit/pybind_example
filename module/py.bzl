"""Bazel build rules for Python."""

def py_extension(name,
                    srcs,
                    srcs_version="PY2AND3",
                    data=None,
                    copts=None,
                    nocopts=None,
                    linkopts=[],
                    deps=[],
                    visibility=None,
                    testonly=None,
                    licenses=None,
                    compatible_with=None,
                    restricted_to=None,
                    deprecation=None):
  """Defines a Python C/C++ extension.

  This rule compiles a statically linked shared object that exports one
  symbol named "init$(basename $name)".
  """
  p = name.rfind("/")
  if p == -1:
    sname = name
    prefix = ""
  else:
    sname = name[p + 1:]
    prefix = name[:p + 1]

  so_file = "%s%s.so" % (prefix, sname)
  pyd_file = "%s%s.pyd" % (prefix, sname)
  symbol = "init%s" % sname
  symbol2 = "init_%s" % sname
  symbol3 = "PyInit_%s" % sname
  exported_symbols_file = "%s-exported-symbols.lds" % name
  version_script_file = "%s-version-script.lds" % name

  native.genrule(
      name = name + "_exported_symbols",
      outs = [exported_symbols_file],
      cmd = "echo '%s\n%s\n%s' >$@" % (symbol, symbol2, symbol3),
      output_licenses = ["unencumbered"],
      visibility = ["//visibility:private"],
      testonly = testonly,
  )

  native.genrule(
      name = name + "_version_script",
      outs = [version_script_file],
      cmd = "echo '{global:\n %s;\n %s;\n %s;\n local: *;};' >$@" % (symbol, symbol2, symbol3),
      output_licenses = ["unencumbered"],
      visibility = ["//visibility:private"],
      testonly = testonly,
  )

  native.cc_binary(
      name = so_file,
      srcs = srcs,
      data = data,
      copts = copts,
      nocopts = nocopts,
      linkopts = linkopts + select({
          "//conditions:default": [
              "-Wl,--version-script",
              "$(location %s)" % version_script_file,
          ],
      }),
      deps = deps + [
          exported_symbols_file,
          version_script_file,
      ],
      linkshared = True,
      testonly = testonly,
      licenses = licenses,
      visibility = visibility,
      deprecation = deprecation,
      restricted_to = restricted_to,
      compatible_with = compatible_with,
  )

  native.genrule(
      name = name + "_pyd_copy",
      srcs = [so_file],
      outs = [pyd_file],
      cmd = "cp $< $@",
      output_to_bindir = True,
      visibility = visibility,
      deprecation = deprecation,
      restricted_to = restricted_to,
      compatible_with = compatible_with,
  )

  native.py_library(
      name = name,
      data = select({
          "//conditions:default": [so_file],
      }),
      srcs_version = srcs_version,
      licenses = licenses,
      testonly = testonly,
      visibility = visibility,
      deprecation = deprecation,
      restricted_to = restricted_to,
      compatible_with = compatible_with,
  )
# Install the shared Quarto extension in a talk project

Copies the `uriahtalks` Quarto extension bundled with this package into
a project's `_extensions` directory and installs the bundled fonts in
the project's `fonts` directory. Existing files are refreshed so
presentations use the theme shipped with the installed package.

## Usage

``` r
use_uriah_quarto(path = ".")
```

## Arguments

- path:

  Path to the Quarto project root.

## Value

Invisibly, the installed extension directory.

# Install the shared Quarto extensions in a project

Copies the `uriahtalks` presentation and brand extensions bundled with
this package into a project's `_extensions` directory. It also installs
the presentation fonts in the project's `fonts` directory. Existing
files are refreshed so projects use the extensions shipped with the
installed package.

## Usage

``` r
use_uriah_quarto(path = ".")
```

## Arguments

- path:

  Path to the Quarto project root.

## Value

Invisibly, the installed presentation extension directory.

# uriahtalks

Shared data, typography, and presentation infrastructure for Uriah
Finkel’s talks and documentation.

## v0.1 goals

- One canonical smoking teaching dataset used across the
  conditional-exchangeability, causal-bounds, experimental-bounds, and
  pure-mediation talks.
- Presentation-specific views through
  [`smoking_data()`](https://uriahf.github.io/uriahtalks/reference/smoking_data.md).
- Validation tests that protect causal truths and published examples
  during refactoring.
- Shared Commissioner/Fraunces typography across Quarto projects.
- A common Quarto/revealjs theme plus ggplot/reactable helpers.

## Current baseline

The current `smoking` object reconstructs the published
conditional-exchangeability example:

- 16 people.
- 6 with `x = 0`, 10 with `x = 1`.
- `E[Y0] = 7/16`, `E[Y1] = 11/16`, so true ATE = `4/16 = 0.25`.
- Four `(Y0, Y1) = (0, 1)` responders, so PNS = `4/16 = 0.25` under
  monotonicity.
- Observational treatment rates `2/6` and `8/10`.
- The observational assignment keeps treatment rates at `2/6` and
  `8/10`. Its naïve contrast is `7/15`; adjustment gives `21/64`, moving
  toward but not landing exactly on the true ATE.
- The balanced experimental assignment is frozen from the experimental
  deck’s `set.seed(42)` construction.

## Intended API

``` r

library(uriahtalks)

obs <- smoking_data("observational")
exp <- smoking_data("experimental")
full <- smoking_data("full")

check_smoking_data()

uriah_theme()
uriah_palette()
uriah_reactable(obs)
use_uriah_quarto()
```

### Shared Quarto typography

For any Quarto project, install the repository’s extensions from the
project root:

``` bash
quarto add uriahf/uriahtalks
```

The `uriah-brand` extension applies Commissioner to body text and
Fraunces to headings. It intentionally contains no colors, logo, or
favicon, so downstream projects retain their own visual identity. R
users can install the same bundled extensions with
[`use_uriah_quarto()`](https://uriahf.github.io/uriahtalks/reference/use_uriah_quarto.md).

In a Quarto presentation, use `format: uriahtalks-revealjs` after
installing the extensions.

### Interactive time-horizon component

The repository also provides a language-neutral interactive time-horizon
shortcode for websites, blog posts, and presentations:

``` markdown
{{< horizon-explorer >}}

{{< horizon-explorer competing-as-censored="true"
    title="Competing events treated as censored" >}}

{{< horizon-explorer competing-as-censored="true"
    min="1" max="5" step="1" horizon="3"
    accent-color="#ce3d15" >}}
```

The component uses browser-native JavaScript and SVG. It does not
require an R, Python, Jupyter, or Observable runtime. Example follow-up
times scale to the configured maximum horizon, and `accent-color`
controls the slider and horizon line.

The repository deliberately contains no Python package.
`_extensions/uriahtalks` is the canonical language-neutral presentation
extension and `_extensions/uriah-brand` is the canonical shared
typography extension. The R package bundles the same files so existing R
workflows can install them with
[`use_uriah_quarto()`](https://uriahf.github.io/uriahtalks/reference/use_uriah_quarto.md).

## Next migration steps

1.  Migrate conditional exchangeability to `uriahtalks` and tune the
    shared SCSS against the existing visual style.
2.  Refactor the remaining decks one at a time.

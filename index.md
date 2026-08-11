# uriahtalks

Shared data and presentation infrastructure for Uriah Finkel’s talks.

## v0.1 goals

- One canonical smoking teaching dataset used across the
  conditional-exchangeability, causal-bounds, experimental-bounds, and
  pure-mediation talks.
- Presentation-specific views through
  [`smoking_data()`](https://uriahf.github.io/uriahtalks/reference/smoking_data.md).
- Validation tests that protect causal truths and published examples
  during refactoring.
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

In a Quarto presentation, use `format: uriahtalks-revealjs` after
installing the extension with
[`use_uriah_quarto()`](https://uriahf.github.io/uriahtalks/reference/use_uriah_quarto.md)
from the project root.

## Next migration steps

1.  Migrate conditional exchangeability to `uriahtalks` and tune the
    shared SCSS against the existing visual style.
2.  Refactor the remaining decks one at a time.

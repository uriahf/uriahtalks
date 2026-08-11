# Getting started with uriahtalks

`uriahtalks` contains shared teaching data and presentation
infrastructure used across Uriah Finkel’s talks.

The first shared example is the smoking dataset. Each presentation
should request only the view it needs while all views remain derived
from the same canonical data.

``` r

library(uriahtalks)

obs <- smoking_data("observational")
exp <- smoking_data("experimental")
med <- smoking_data("mediation")
full <- smoking_data("full")
```

The observational view is intended for slides that work only with
factual data. The full view exposes the underlying constructed data used
to verify causal truths and keep related presentations consistent.

The package also provides shared visual defaults:

``` r

library(ggplot2)

ggplot(obs, aes(x = x, fill = factor(a))) +
  geom_bar() +
  uriah_theme() +
  scale_fill_uriah()
```

For `reactable` tables:

``` r

uriah_reactable(obs)
```

For a Quarto/revealjs talk, install or refresh the bundled extension in
the project root and select its format in the presentation front matter:

``` r

use_uriah_quarto()
```

``` yaml
format: uriahtalks-revealjs
```

Before changing the canonical smoking data, run:

``` r

check_smoking_data()
```

The package tests encode the invariants that need to remain stable
across the conditional-exchangeability, causal-bounds,
experimental-bounds, and mediation presentations.

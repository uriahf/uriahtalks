# Return a presentation-specific view of the smoking data

Return a presentation-specific view of the smoking data

## Usage

``` r
smoking_data(view = c("observational", "mediation", "full"))
```

## Arguments

- view:

  One of `"observational"`, `"mediation"`, or `"full"`. The experimental
  view will be added once the seeded RCT assignment used in the
  experimental-bounds deck is frozen into the canonical table.

## Value

A tibble.

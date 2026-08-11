# Canonical smoking teaching dataset

A 16-person constructed dataset shared across the smoking-based talks.
The object stores the potential outcomes used by the observational
bounds, experimental bounds, and pure mediation presentations, together
with the realized observational and randomized assignments.

## Usage

``` r
smoking
```

## Format

A tibble with 16 rows and columns:

- id:

  Person identifier, preserving the row order used in the talks.

- x:

  Background covariate: parental smoking.

- m0:

  Mediator under no smoking.

- m1:

  Mediator under smoking.

- ym0:

  Outcome under mediator level 0.

- ym1:

  Outcome under mediator level 1.

- y0:

  Outcome under no smoking, derived under pure mediation.

- y1:

  Outcome under smoking, derived under pure mediation.

- a_obs:

  Observed/natural smoking assignment used across observational talks.

- a_exp:

  Frozen randomized assignment from the experimental-bounds talk.

- m_obs:

  Observed mediator, derived by consistency.

- y_obs:

  Observed outcome, derived by consistency.

## Details

The mediation representation is deliberately primitive: `m0` and `m1`
are mediator potential outcomes under treatment 0 and 1, while `ym0` and
`ym1` are outcome potential outcomes under mediator 0 and 1. Under the
pure mediation construction, `y0` and `y1` are derived as `Y(M(0))` and
`Y(M(1))` rather than maintained independently.

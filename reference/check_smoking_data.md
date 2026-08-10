# Validate the canonical smoking dataset

Checks the invariants relied on by the smoking presentations, including
the pure-mediation relationships used to derive treatment potential
outcomes. Returns invisibly on success and throws an informative error
on failure.

## Usage

``` r
check_smoking_data(data = smoking)
```

## Arguments

- data:

  Full smoking dataset. Defaults to
  [smoking](https://uriahf.github.io/uriahtalks/reference/smoking.md).

## Value

Invisibly, `TRUE`.

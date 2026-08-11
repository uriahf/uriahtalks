# Search alternative observational treatment allocations while keeping the
# 16-person causal types fixed. This script intentionally does not overwrite
# the canonical data automatically; candidate selection is a pedagogical choice.

library(dplyr)

full <- uriahtalks::smoking
published_assignment <- as.integer(full$id %in% c(1:2, 7:14))

# Enumerate exactly 2 treated among the 6 x=0 individuals and exactly 8 treated
# among the 10 x=1 individuals. Selection criteria:
# - true ATE remains 0.25
# - PNS and subgroup PNS remain unchanged
# - treatment rates remain 2/6 and 8/10 unless there is a strong reason to alter them
# - naive association visibly differs from the true ATE
# - adjusted nonparametric estimate moves toward 0.25 but does not equal it exactly
# - observed-data bounds remain simple enough to teach on slides

assignments <- tidyr::crossing(
  x0 = combn(which(full$x == 0), 2, simplify = FALSE),
  x1 = combn(which(full$x == 1), 8, simplify = FALSE)
) |>
  rowwise() |>
  mutate(
    treated_ids = list(c(x0, x1)),
    a = list(as.integer(full$id %in% treated_ids)),
    y = list(if_else(a == 1, full$y1, full$y0)),
    naive = mean(y[a == 1]) - mean(y[a == 0]),
    risk_00 = mean(y[full$x == 0 & a == 0]),
    risk_10 = mean(y[full$x == 0 & a == 1]),
    risk_01 = mean(y[full$x == 1 & a == 0]),
    risk_11 = mean(y[full$x == 1 & a == 1]),
    adjusted = 6 / 16 * (risk_10 - risk_00) +
      10 / 16 * (risk_11 - risk_01),
    assignment_changes = sum(a != published_assignment)
  ) |>
  ungroup()

# Selected allocation: ids 1, 2, 7:13, and 16. Relative to the old published
# assignment, this swaps ids 14 and 16. It gives a naive contrast of 7/15 and
# an adjusted contrast of 21/64, with cell risks 1/4, 1/2, 1/2, and 7/8.
selected <- assignments |>
  filter(
    vapply(treated_ids, identical, logical(1), as.integer(c(1:2, 7:13, 16))),
    near(naive, 7 / 15),
    near(adjusted, 21 / 64)
  )

stopifnot(nrow(selected) == 1)

# Search alternative observational treatment allocations while keeping the
# 16-person causal types fixed. This script intentionally does not overwrite
# the canonical data automatically; candidate selection is a pedagogical choice.

library(dplyr)

full <- uriahtalks::smoking

# Next iteration: enumerate exactly 2 treated among the 6 x=0 individuals and
# exactly 8 treated among the 10 x=1 individuals.
#
# Selection criteria:
# - true ATE remains 0.25
# - PNS and subgroup PNS remain unchanged
# - treatment rates remain 2/6 and 8/10 unless there is a strong reason to alter them
# - naive association visibly differs from the true ATE
# - adjusted nonparametric estimate moves toward 0.25 but does not equal it exactly
# - observed-data bounds remain simple enough to teach on slides

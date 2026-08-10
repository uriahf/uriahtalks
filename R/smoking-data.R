#' Canonical smoking teaching dataset
#'
#' A 16-person constructed dataset shared across the smoking-based talks.
#' The object stores the full treatment potential outcomes and the realized
#' observational assignment. Mediation and experimental columns will be added
#' once those decks are migrated into the canonical representation.
#'
#' @format A tibble with 16 rows and columns:
#' \describe{
#'   \item{id}{Person identifier.}
#'   \item{x}{Background covariate: parental smoking.}
#'   \item{y0}{Outcome under no smoking.}
#'   \item{y1}{Outcome under smoking.}
#'   \item{a_obs}{Observed/natural smoking assignment in the observational deck.}
#'   \item{y_obs}{Observed outcome, derived by consistency from a_obs, y0, and y1.}
#' }
#' @export
smoking <- tibble::tribble(
  ~id, ~x, ~y0, ~y1, ~a_obs,
    1,  0,   0,   1,      0,
    2,  0,   0,   1,      0,
    3,  0,   1,   1,      0,
    4,  0,   1,   1,      1,
    5,  0,   0,   0,      1,
    6,  0,   0,   0,      0,
    7,  1,   0,   1,      1,
    8,  1,   0,   1,      1,
    9,  1,   1,   1,      0,
   10,  1,   1,   1,      1,
   11,  1,   1,   1,      1,
   12,  1,   1,   1,      1,
   13,  1,   1,   1,      1,
   14,  1,   0,   0,      0,
   15,  1,   0,   0,      1,
   16,  1,   0,   0,      1
) |>
  dplyr::mutate(y_obs = dplyr::if_else(a_obs == 1, y1, y0))

#' Return a presentation-specific view of the smoking data
#'
#' @param view One of "observational" or "full". Experimental and mediation
#'   views are reserved for the next migration stage.
#' @return A tibble.
#' @export
smoking_data <- function(view = c("observational", "full")) {
  view <- match.arg(view)

  if (view == "observational") {
    return(
      smoking |>
        dplyr::select(id, x, a = a_obs, y = y_obs)
    )
  }

  smoking
}

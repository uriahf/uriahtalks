#' Canonical smoking teaching dataset
#'
#' A 16-person constructed dataset shared across the smoking-based talks.
#' The object stores the potential outcomes used by the observational bounds,
#' experimental bounds, and pure mediation presentations, together with the
#' realized observational and randomized assignments.
#'
#' The mediation representation is deliberately primitive: `m0` and `m1` are
#' mediator potential outcomes under treatment 0 and 1, while `ym0` and `ym1`
#' are outcome potential outcomes under mediator 0 and 1. Under the pure
#' mediation construction, `y0` and `y1` are derived as `Y(M(0))` and
#' `Y(M(1))` rather than maintained independently.
#'
#' @format A tibble with 16 rows and columns:
#' \describe{
#'   \item{id}{Person identifier, preserving the row order used in the talks.}
#'   \item{x}{Background covariate: parental smoking.}
#'   \item{m0}{Mediator under no smoking.}
#'   \item{m1}{Mediator under smoking.}
#'   \item{ym0}{Outcome under mediator level 0.}
#'   \item{ym1}{Outcome under mediator level 1.}
#'   \item{y0}{Outcome under no smoking, derived under pure mediation.}
#'   \item{y1}{Outcome under smoking, derived under pure mediation.}
#'   \item{a_obs}{Observed/natural smoking assignment used across observational talks.}
#'   \item{a_exp}{Frozen randomized assignment from the experimental-bounds talk.}
#'   \item{m_obs}{Observed mediator, derived by consistency.}
#'   \item{y_obs}{Observed outcome, derived by consistency.}
#' }
#' @export
smoking <- tibble::tribble(
  ~id, ~x, ~a_obs, ~a_exp, ~m0, ~m1, ~ym0, ~ym1,
    1,  0,      1,      0,   0,   1,    0,    1,
    2,  0,      1,      0,   0,   0,    0,    0,
    3,  0,      0,      1,   1,   1,    1,    1,
    4,  0,      0,      1,   0,   1,    0,    1,
    5,  0,      0,      1,   0,   0,    0,    0,
    6,  0,      0,      0,   0,   0,    0,    0,
    7,  1,      1,      0,   1,   1,    0,    1,
    8,  1,      1,      1,   1,   1,    0,    1,
    9,  1,      1,      0,   1,   1,    0,    1,
   10,  1,      1,      0,   0,   0,    1,    1,
   11,  1,      1,      1,   1,   1,    1,    1,
   12,  1,      1,      1,   0,   1,    0,    1,
   13,  1,      1,      1,   0,   0,    0,    1,
   14,  1,      0,      1,   0,   0,    0,    0,
   15,  1,      0,      0,   1,   1,    0,    1,
   16,  1,      1,      0,   0,   1,    0,    1
) |>
  dplyr::mutate(
    y0 = dplyr::if_else(m0 == 1, ym1, ym0),
    y1 = dplyr::if_else(m1 == 1, ym1, ym0),
    m_obs = dplyr::if_else(a_obs == 1, m1, m0),
    y_obs = dplyr::if_else(a_obs == 1, y1, y0)
  ) |>
  dplyr::relocate(y0, y1, .after = ym1)

#' Return a presentation-specific view of the smoking data
#'
#' @param view One of `"observational"`, `"experimental"`, `"mediation"`,
#'   or `"full"`.
#' @return A tibble.
#' @export
smoking_data <- function(view = c("observational", "experimental", "mediation", "full")) {
  view <- match.arg(view)

  if (view == "observational") {
    return(
      smoking |>
        dplyr::select(id, x, a = a_obs, y = y_obs)
    )
  }

  if (view == "experimental") {
    return(
      smoking |>
        dplyr::mutate(y = dplyr::if_else(a_exp == 1, y1, y0)) |>
        dplyr::select(id, x, a = a_exp, y)
    )
  }

  if (view == "mediation") {
    return(
      smoking |>
        dplyr::select(id, x, a = a_obs, m = m_obs, y = y_obs)
    )
  }

  smoking
}

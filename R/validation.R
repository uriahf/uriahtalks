#' Validate the canonical smoking dataset
#'
#' Checks the invariants relied on by the smoking presentations, including the
#' pure-mediation relationships used to derive treatment potential outcomes.
#' Returns invisibly on success and throws an informative error on failure.
#'
#' @param data Full smoking dataset. Defaults to [smoking].
#' @return Invisibly, `TRUE`.
#' @export
check_smoking_data <- function(data = smoking) {
  derived_y0 <- ifelse(data$m0 == 1, data$ym1, data$ym0)
  derived_y1 <- ifelse(data$m1 == 1, data$ym1, data$ym0)
  derived_m_obs <- ifelse(data$a_obs == 1, data$m1, data$m0)
  derived_y_obs <- ifelse(data$a_obs == 1, data$y1, data$y0)
  seeded_experimental_assignment <- c(0L, 0L, 1L, 1L, 1L, 0L, 0L, 1L,
                                      0L, 0L, 1L, 1L, 1L, 1L, 0L, 0L)

  checks <- c(
    "16 individuals" = nrow(data) == 16,
    "6 people with x = 0" = sum(data$x == 0) == 6,
    "10 people with x = 1" = sum(data$x == 1) == 10,
    "pure mediation derives y0" = all(data$y0 == derived_y0),
    "pure mediation derives y1" = all(data$y1 == derived_y1),
    "E[Y0] = 7/16" = isTRUE(all.equal(mean(data$y0), 7 / 16)),
    "E[Y1] = 11/16" = isTRUE(all.equal(mean(data$y1), 11 / 16)),
    "ATE = 4/16" = isTRUE(all.equal(mean(data$y1 - data$y0), 4 / 16)),
    "PNS = 4/16" = isTRUE(all.equal(mean(data$y0 == 0 & data$y1 == 1), 4 / 16)),
    "PNS | x=0 = 2/6" = isTRUE(all.equal(mean(data$y0[data$x == 0] == 0 & data$y1[data$x == 0] == 1), 2 / 6)),
    "PNS | x=1 = 2/10" = isTRUE(all.equal(mean(data$y0[data$x == 1] == 0 & data$y1[data$x == 1] == 1), 2 / 10)),
    "P(A=1 | x=0) = 2/6" = isTRUE(all.equal(mean(data$a_obs[data$x == 0]), 2 / 6)),
    "P(A=1 | x=1) = 8/10" = isTRUE(all.equal(mean(data$a_obs[data$x == 1]), 8 / 10)),
    "experimental assignment reproduces seed 42" = identical(as.integer(data$a_exp), seeded_experimental_assignment),
    "experimental assignment is balanced" = sum(data$a_exp) == 8,
    "observed mediator satisfies consistency" = all(data$m_obs == derived_m_obs),
    "observed outcome satisfies consistency" = all(data$y_obs == derived_y_obs)
  )

  if (!all(checks)) {
    failed <- names(checks)[!checks]
    stop(
      "Canonical smoking data failed validation:\n- ",
      paste(failed, collapse = "\n- "),
      call. = FALSE
    )
  }

  invisible(TRUE)
}

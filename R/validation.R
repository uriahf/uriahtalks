#' Validate the canonical smoking dataset
#'
#' Checks the invariants currently relied on by the smoking presentations.
#' Returns invisibly on success and throws an informative error on failure.
#'
#' @param data Full smoking dataset. Defaults to [smoking].
#' @return Invisibly, `TRUE`.
#' @export
check_smoking_data <- function(data = smoking) {
  checks <- c(
    "16 individuals" = nrow(data) == 16,
    "6 people with x = 0" = sum(data$x == 0) == 6,
    "10 people with x = 1" = sum(data$x == 1) == 10,
    "E[Y0] = 7/16" = isTRUE(all.equal(mean(data$y0), 7 / 16)),
    "E[Y1] = 11/16" = isTRUE(all.equal(mean(data$y1), 11 / 16)),
    "ATE = 4/16" = isTRUE(all.equal(mean(data$y1 - data$y0), 4 / 16)),
    "PNS = 4/16" = isTRUE(all.equal(mean(data$y0 == 0 & data$y1 == 1), 4 / 16)),
    "PNS | x=0 = 2/6" = isTRUE(all.equal(mean(data$y0[data$x == 0] == 0 & data$y1[data$x == 0] == 1), 2 / 6)),
    "PNS | x=1 = 2/10" = isTRUE(all.equal(mean(data$y0[data$x == 1] == 0 & data$y1[data$x == 1] == 1), 2 / 10)),
    "P(A=1 | x=0) = 2/6" = isTRUE(all.equal(mean(data$a_obs[data$x == 0]), 2 / 6)),
    "P(A=1 | x=1) = 8/10" = isTRUE(all.equal(mean(data$a_obs[data$x == 1]), 8 / 10)),
    "observed outcomes satisfy consistency" = all(data$y_obs == ifelse(data$a_obs == 1, data$y1, data$y0))
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

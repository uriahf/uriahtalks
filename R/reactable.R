#' Shared reactable defaults for Uriah talks
#'
#' @param data A data frame.
#' @param ... Additional arguments passed to [reactable::reactable()].
#' @export
uriah_reactable <- function(data, ...) {
  reactable::reactable(
    data,
    bordered = FALSE,
    striped = FALSE,
    highlight = TRUE,
    compact = FALSE,
    defaultPageSize = nrow(data),
    ...
  )
}

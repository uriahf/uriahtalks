#' Uriah talks semantic color palette
#'
#' @return A named character vector of semantic presentation colors.
#' @export
uriah_palette <- function() {
  c(
    treatment = "#B75D3E",
    control = "#355C7D",
    factual = "#2F6B5F",
    counterfactual = "#7B6AA8",
    highlight = "#D19A3E",
    muted = "#8B8B8B",
    ink = "#252525",
    background = "#F7F2E8"
  )
}

#' @export
scale_color_uriah <- function(...) {
  ggplot2::scale_color_manual(values = uriah_palette(), ...)
}

#' @export
scale_fill_uriah <- function(...) {
  ggplot2::scale_fill_manual(values = uriah_palette(), ...)
}

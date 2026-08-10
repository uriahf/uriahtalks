#' Shared ggplot theme for Uriah talks
#'
#' Initial theme shell. Typography and spacing should be tuned during the
#' conditional-exchangeability migration against the existing decks.
#'
#' @param base_size Base font size.
#' @param base_family Base font family.
#' @export
uriah_theme <- function(base_size = 18, base_family = "sans") {
  ggplot2::theme_minimal(base_size = base_size, base_family = base_family) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(face = "bold", size = base_size * 1.35),
      plot.subtitle = ggplot2::element_text(size = base_size),
      axis.title = ggplot2::element_text(face = "bold"),
      panel.grid.minor = ggplot2::element_blank(),
      legend.title = ggplot2::element_text(face = "bold")
    )
}

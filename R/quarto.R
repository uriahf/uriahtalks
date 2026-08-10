#' Install the shared Quarto extension in a talk project
#'
#' Copies the `uriahtalks` Quarto extension bundled with this package into a
#' project's `_extensions` directory and installs the bundled fonts in the
#' project's `fonts` directory. Existing files are refreshed so presentations
#' use the theme shipped with the installed package.
#'
#' @param path Path to the Quarto project root.
#' @return Invisibly, the installed extension directory.
#' @export
use_uriah_quarto <- function(path = ".") {
  source <- system.file("quarto", "uriahtalks", package = "uriahtalks")

  if (!nzchar(source)) {
    stop("The bundled uriahtalks Quarto extension was not found.", call. = FALSE)
  }

  target <- file.path(normalizePath(path, mustWork = TRUE), "_extensions", "uriahtalks")
  files <- list.files(source, recursive = TRUE, all.files = TRUE, no.. = TRUE)

  dir.create(target, recursive = TRUE, showWarnings = FALSE)

  for (file in files) {
    from <- file.path(source, file)
    to <- file.path(target, file)

    if (dir.exists(from)) {
      dir.create(to, recursive = TRUE, showWarnings = FALSE)
    } else {
      dir.create(dirname(to), recursive = TRUE, showWarnings = FALSE)
      if (!file.copy(from, to, overwrite = TRUE, copy.mode = TRUE)) {
        stop("Failed to install Quarto extension file: ", file, call. = FALSE)
      }
    }
  }

  font_source <- file.path(source, "fonts")
  font_target <- file.path(normalizePath(path, mustWork = TRUE), "fonts")
  fonts <- list.files(font_source, full.names = TRUE)

  dir.create(font_target, recursive = TRUE, showWarnings = FALSE)

  for (font in fonts) {
    to <- file.path(font_target, basename(font))
    if (!file.copy(font, to, overwrite = TRUE, copy.mode = TRUE)) {
      stop("Failed to install presentation font: ", basename(font), call. = FALSE)
    }
  }

  invisible(target)
}

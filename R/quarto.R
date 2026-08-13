#' Install the shared Quarto extensions in a project
#'
#' Copies the `uriahtalks` presentation and brand extensions bundled with this
#' package into a project's `_extensions` directory. It also installs the
#' presentation fonts in the project's `fonts` directory. Existing files are
#' refreshed so projects use the extensions shipped with the installed package.
#'
#' @param path Path to the Quarto project root.
#' @return Invisibly, the installed presentation extension directory.
#' @export
use_uriah_quarto <- function(path = ".") {
  project <- normalizePath(path, mustWork = TRUE)
  source_root <- system.file("quarto", package = "uriahtalks")
  extension_names <- c("uriahtalks", "uriah-brand")

  if (!nzchar(source_root)) {
    stop("The bundled uriahtalks Quarto extensions were not found.", call. = FALSE)
  }

  for (extension_name in extension_names) {
    source <- file.path(source_root, extension_name)

    if (!dir.exists(source)) {
      stop("The bundled Quarto extension was not found: ", extension_name, call. = FALSE)
    }

    target <- file.path(project, "_extensions", extension_name)
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
  }

  font_source <- file.path(source_root, "uriahtalks", "fonts")
  font_target <- file.path(project, "fonts")
  fonts <- list.files(font_source, full.names = TRUE)

  dir.create(font_target, recursive = TRUE, showWarnings = FALSE)

  for (font in fonts) {
    to <- file.path(font_target, basename(font))
    if (!file.copy(font, to, overwrite = TRUE, copy.mode = TRUE)) {
      stop("Failed to install presentation font: ", basename(font), call. = FALSE)
    }
  }

  invisible(file.path(project, "_extensions", "uriahtalks"))
}

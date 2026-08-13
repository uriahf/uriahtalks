test_that("shared Quarto extension can be installed in a project", {
  project <- withr::local_tempdir()

  extension <- use_uriah_quarto(project)

  expect_true(file.exists(file.path(extension, "_extension.yml")))
  expect_true(file.exists(file.path(extension, "uriahtalks.scss")))
  expect_true(file.exists(file.path(extension, "horizon-explorer.lua")))
  expect_true(file.exists(file.path(project, "fonts", "commissioner-v13-latin-regular.woff2")))
  expect_true(file.exists(file.path(project, "fonts", "Fraunces9pt-Light.woff2")))
})

test_that("horizon explorer supports observed and censoring modes", {
  shortcode <- readLines(
    system.file("quarto", "uriahtalks", "horizon-explorer.lua", package = "uriahtalks"),
    warn = FALSE
  )

  expect_true(any(grepl('competing-as-censored', shortcode, fixed = TRUE)))
  expect_true(any(grepl('Competing event', shortcode, fixed = TRUE)))
  expect_true(any(grepl('Censored', shortcode, fixed = TRUE)))
  expect_true(any(grepl('timeFraction', shortcode, fixed = TRUE)))
  expect_true(any(grepl('accent-color', shortcode, fixed = TRUE)))
})

test_that("standalone and R-bundled extensions stay synchronized", {
  root <- testthat::test_path("..", "..")
  standalone <- file.path(root, "_extensions", "uriahtalks")
  bundled <- file.path(root, "inst", "quarto", "uriahtalks")
  files <- c("_extension.yml", "horizon-explorer.lua", "uriahtalks.scss")

  for (file in files) {
    expect_identical(
      readLines(file.path(standalone, file), warn = FALSE),
      readLines(file.path(bundled, file), warn = FALSE),
      info = paste(file, "differs between standalone and bundled extensions")
    )
  }
})

test_that("shared Quarto extensions can be installed in a project", {
  project <- withr::local_tempdir()

  extension <- use_uriah_quarto(project)
  brand <- file.path(project, "_extensions", "uriah-brand")

  expect_true(file.exists(file.path(extension, "_extension.yml")))
  expect_true(file.exists(file.path(extension, "uriahtalks.scss")))
  expect_true(file.exists(file.path(extension, "horizon-explorer.lua")))
  expect_true(file.exists(file.path(brand, "_extension.yml")))
  expect_true(file.exists(file.path(brand, "brand.yml")))
  expect_true(file.exists(file.path(brand, "fonts", "commissioner-v13-latin-regular.woff2")))
  expect_true(file.exists(file.path(brand, "fonts", "Fraunces9pt-Light.woff2")))
  expect_true(file.exists(file.path(project, "fonts", "commissioner-v13-latin-regular.woff2")))
  expect_true(file.exists(file.path(project, "fonts", "Fraunces9pt-Light.woff2")))
})

test_that("shared brand defines typography without overriding project colors", {
  brand <- readLines(
    system.file("quarto", "uriah-brand", "brand.yml", package = "uriahtalks"),
    warn = FALSE
  )

  expect_true(any(grepl("Commissioner", brand, fixed = TRUE)))
  expect_true(any(grepl("Fraunces", brand, fixed = TRUE)))
  expect_false(any(grepl("^color:", brand)))
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
  extension_files <- list(
    uriahtalks = c("_extension.yml", "horizon-explorer.lua", "uriahtalks.scss"),
    "uriah-brand" = c("_extension.yml", "brand.yml")
  )

  for (extension_name in names(extension_files)) {
    standalone <- file.path(root, "_extensions", extension_name)
    bundled <- file.path(root, "inst", "quarto", extension_name)

    for (file in extension_files[[extension_name]]) {
      expect_identical(
        readLines(file.path(standalone, file), warn = FALSE),
        readLines(file.path(bundled, file), warn = FALSE),
        info = paste(file, "differs between standalone and bundled", extension_name)
      )
    }
  }
})

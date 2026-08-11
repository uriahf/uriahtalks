test_that("shared Quarto extension can be installed in a project", {
  project <- withr::local_tempdir()

  extension <- use_uriah_quarto(project)

  expect_true(file.exists(file.path(extension, "_extension.yml")))
  expect_true(file.exists(file.path(extension, "uriahtalks.scss")))
  expect_true(file.exists(file.path(project, "fonts", "commissioner-v13-latin-regular.woff2")))
  expect_true(file.exists(file.path(project, "fonts", "Fraunces9pt-Light.woff2")))
})

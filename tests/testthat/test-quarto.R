test_that("shared Quarto extension can be installed in a project", {
  project <- withr::local_tempdir()

  extension <- use_uriah_quarto(project)

  expect_true(file.exists(file.path(extension, "_extension.yml")))
  expect_true(file.exists(file.path(extension, "uriahtalks.scss")))
})

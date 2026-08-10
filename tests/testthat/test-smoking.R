test_that("canonical smoking world stays internally consistent", {
  expect_true(check_smoking_data())
})

test_that("published conditional-exchangeability baseline is reproduced", {
  obs <- smoking_data("observational")

  expect_equal(mean(obs$a[obs$x == 0]), 2 / 6)
  expect_equal(mean(obs$a[obs$x == 1]), 8 / 10)

  expect_equal(mean(obs$y[obs$x == 0 & obs$a == 0]), 1 / 4)
  expect_equal(mean(obs$y[obs$x == 0 & obs$a == 1]), 1 / 2)
  expect_equal(mean(obs$y[obs$x == 1 & obs$a == 0]), 1 / 2)
  expect_equal(mean(obs$y[obs$x == 1 & obs$a == 1]), 6 / 8)

  naive <- mean(obs$y[obs$a == 1]) - mean(obs$y[obs$a == 0])
  expect_equal(naive, 7 / 10 - 2 / 6)
})

test_that("canonical smoking world stays internally consistent", {
  expect_true(check_smoking_data())
})

test_that("observational assignment is confounded but adjustment helps", {
  obs <- smoking_data("observational")

  expect_equal(mean(obs$a[obs$x == 0]), 2 / 6)
  expect_equal(mean(obs$a[obs$x == 1]), 8 / 10)

  expect_equal(mean(obs$y[obs$x == 0 & obs$a == 0]), 1 / 4)
  expect_equal(mean(obs$y[obs$x == 0 & obs$a == 1]), 1 / 2)
  expect_equal(mean(obs$y[obs$x == 1 & obs$a == 0]), 1 / 2)
  expect_equal(mean(obs$y[obs$x == 1 & obs$a == 1]), 7 / 8)

  naive <- mean(obs$y[obs$a == 1]) - mean(obs$y[obs$a == 0])
  adjusted <- sum(c(6 / 16, 10 / 16) * c(1 / 2 - 1 / 4, 7 / 8 - 1 / 2))

  expect_equal(naive, 7 / 15)
  expect_equal(adjusted, 21 / 64)
  expect_lt(abs(adjusted - 1 / 4), abs(naive - 1 / 4))
  expect_false(isTRUE(all.equal(adjusted, 1 / 4)))
})

test_that("experimental view freezes the deck's seeded assignment", {
  exp <- smoking_data("experimental")

  expect_equal(exp$a, c(0L, 0L, 1L, 1L, 1L, 0L, 0L, 1L,
                        0L, 0L, 1L, 1L, 1L, 1L, 0L, 0L))
  expect_equal(sum(exp$a), 8)
  expect_equal(exp$y, ifelse(exp$a == 1, smoking$y1, smoking$y0))
})

test_that("presentation views expose stable schemas", {
  expect_named(smoking_data("observational"), c("id", "x", "a", "y"))
  expect_named(smoking_data("experimental"), c("id", "x", "a", "y"))
  expect_named(smoking_data("mediation"), c("id", "x", "a", "m", "y"))
  expect_named(smoking_data("full"), names(smoking))
})

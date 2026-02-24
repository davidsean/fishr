test_that("CPUE calculates simple ratio", {
  expect_equal(cpue(catch = 100, effort = 10), 10)
  expect_equal(cpue(catch = 50, effort = 2), 25)
})


test_that("CPUE calculates ratio with vectors", {
  catch <- c(100, 200, 300)
  effort <- c(10, 20, 10)
  expected_cpue <- c(10, 10, 30)
  expect_equal(cpue(catch, effort), expected_cpue)
})

test_that(" CPUE returns numeric values", {
  expect_type(cpue(100, 10), "double")
})

test_that("CPUE uses gear factor", {
  expect_equal(
    cpue(catch = 50, effort = 2),
    cpue(catch = 50, effort = 2, gear_factor = 1)
  )
  expect_equal(cpue(catch = 50, effort = 2, gear_factor = 0.5), 12.5)
})

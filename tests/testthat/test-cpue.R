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

test_that("CPUE works with generated data", {
  data <- generate_fishing_data(n = 4)
  result <- cpue(
    catch = data$catch,
    effort = data$effort,
    gear_factor = data$gear_factor
  )
  expect_equal(result, c(159.16, 26.472, 36.84, 128.77), tolerance = 0.01)
})

test_that("CPUE match ref data", {
  result <- cpue(
    catch = reference_data$catch,
    effort = reference_data$effort
  )
  expect_equal(result, reference_data$expected_cpue)
})


test_that("test verbose", {
  expect_message(
    cpue(
      catch = c(100, 200),
      effort = c(10, 20),
      verbose = TRUE
    ),
    "Processing 2 records"
  )
  expect_no_message(cpue(
    catch = c(100, 200),
    effort = c(10, 20)
  ))
})

test_that("CPUE errors when input is not numeric", {
  expect_snapshot(
    cpue("five", 10),
    error = TRUE
  )
})

test_that("biomass calculates simple ratio", {
  expect_equal(biomass_index(cpue = 100, area_swept = 10), 10)
})


test_that("biomass with vectors simple ratio", {
  expect_equal(
    biomass_index(cpue = c(100, 200), area_swept = c(10, 20)),
    c(10, 10)
  )
})


test_that("Biomass_index uses verbosity option", {
  withr::local_options(fishr.verbose = TRUE) # will be reset when this test_that block finishes
  expect_snapshot(
    biomass_index(cpue = c(100, 200), area_swept = c(10, 20))
  )
})

test_that("Biomass_index uses verbosity option", {
  withr::local_options(fishr.verbose = FALSE) # will be reset when this test_that block finishes
  expect_silent(biomass_index(cpue = c(100, 200), area_swept = c(10, 20)))
})

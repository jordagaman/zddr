test_that("zdds cannot have negative values", {
  testthat::expect_error(zdd(-2L), 'negative')
})

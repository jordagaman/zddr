test_that("zdds cannot have negative values", {
  testthat::expect_error(as_zdd(-2L), 'negative')
})

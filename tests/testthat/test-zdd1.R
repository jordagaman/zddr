test_that("zdd1 works", {
  reset_zdd_store(quiet = TRUE)
  test_func <- function() {
    exists('ffffffffffffffffffffffffffffffff', envir = zddr::zdd_store)
  }
  expect_false(test_func())
  zdd1()
  expect_true(test_func())
})


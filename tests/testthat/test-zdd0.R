test_that("zdd0 works", {
  # zdd0 should add 00000000000000000000000000000000 to zdd_store
  reset_zdd_store(quiet = TRUE)
  test_func <- function() {
    exists('00000000000000000000000000000000', envir = zddr::zdd_store)
  }
  expect_false(test_func())
  zdd0()
  expect_true(test_func())
})


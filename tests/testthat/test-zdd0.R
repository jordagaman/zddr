test_that("zdd0 works", {
  # zdd0 should add d93e93351850a7687ef0cadda5f46681 to zdd_store
  reset_zdd_store(quiet = TRUE)
  test_func <- function() {
    exists('d93e93351850a7687ef0cadda5f46681', envir = zddr::zdd_store)
  }
  expect_false(test_func())
  zdd0()
  expect_true(test_func())
})


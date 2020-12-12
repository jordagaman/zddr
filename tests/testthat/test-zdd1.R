test_that("zdd1 works", {
  # zdd1 should add fca1155cd0feba8b69b4a1f015941e04 to zdd_store
  test_func <- function() {
    exists('fca1155cd0feba8b69b4a1f015941e04', envir = zddr::zdd_store)
  }
  expect_false(test_func())
  zdd1()
  expect_true(test_func())
})


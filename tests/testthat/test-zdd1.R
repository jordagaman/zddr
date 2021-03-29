test_that("zdd1 works", {
  reset_zdd_store(keep_protected = FALSE, quiet = TRUE)
  expect_false(zddr:::zdd_exists('ffffffffffffffffffffffffffffffff'))
  zdd1()
  expect_true(zddr:::zdd_exists('ffffffffffffffffffffffffffffffff'))
})


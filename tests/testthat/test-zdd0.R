test_that("zdd0 works", {
  # zdd0 should add 00000000000000000000000000000000 to zdd_store
  reset_zdd_store(quiet = TRUE)
  expect_false(zddr:::zdd_exists('00000000000000000000000000000000'))
  zdd0()
  expect_true(zddr:::zdd_exists('00000000000000000000000000000000'))
})


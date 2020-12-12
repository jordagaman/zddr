test_that("is_equal works", {
  p <- as_zdd(4L)
  q <- as_zdd(4L)
  r <- as_zdd(5L)
  expect_true(is_equal(p,q))
  expect_false(is_equal(p,r))
})

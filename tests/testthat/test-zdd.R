test_that("hashes still work", {
  p0 <- zdd0()
  node <- zdd(1L, p0, p0)
  expect_equal(p0(node), p0)
  expect_equal(p1(node), p0)
  expect_s3_class(node, "zdd")
})

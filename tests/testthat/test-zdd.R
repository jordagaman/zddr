test_that("hashes still work", {
  node <- zdd(1L, zdd0(), zdd1())
  expect_equal(p0(node), zdd0())
  expect_equal(p1(node), zdd1())
  expect_s3_class(node, "zdd")
})

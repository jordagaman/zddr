test_that("hashes still work", {
  p0 <- zdd0()
  node <- zdd(1L, p0, p0)
  expect_equal(node$p0, as.character(p0))
  expect_equal(node$p1, as.character(p0))
  expect_s3_class(node, "zdd")
})

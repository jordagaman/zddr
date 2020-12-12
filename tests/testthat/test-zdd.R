test_that("hashes still work", {
  p0 <- '420767073edd8b7097448d6c27bf5534'
  node <- zdd(1L, p0, p0)
  expect_equal(node$p0, p0)
  expect_equal(node$p1, p0)
})

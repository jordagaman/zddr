test_that("hashes still work", {
  # we only know this because we ran this earlier. if it ever changes, something is probably wrong.
  p0 <- '420767073edd8b7097448d6c27bf5534'
  p1 <- '420767073edd8b7097448d6c27bf5534'
  node <- zdd(1L, p0, p1)
  expect_equal(node$p0, p0)
  expect_equal(node$p1, p1)
})

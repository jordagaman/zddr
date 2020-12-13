test_that("zdd_union works", {
  expec   <- list( c(3L) , c(4L) )
  result1 <- cutsets( zdd_union(as_zdd(4L), as_zdd(3L) ) )
  result2 <- cutsets( zdd_union(as_zdd(3L), as_zdd(4L) ) )
  result3 <- cutsets(           as_zdd(3L) | as_zdd(4L)  )
  expect_equal(expec, result1)
  expect_equal(expec, result2)
  expect_equal(expec, result3)
})

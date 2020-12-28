test_that("zdd_crossproduct works", {
  library(magrittr)
  zdd1 <- zdd_or(1,2,3,4,5)
  zdd2 <- zdd_or(  6,7,8,9)
  zdd3 <- zdd_or(5,6,7,8,9)

  expect_equal(  attr(zdd1*zdd2, 'count')  , 20L)
  expect_equal(
    cutsets( (zdd(1L)|zdd(2L)) * (zdd(3L)|zdd(4L)) ),
    list(c(1,3),
         c(2,3),
         c(1,4),
         c(2,4))
  )
  expect_equal( zdd_and(1,2,3,4) * zdd_and(1,3) , zdd_and(1,2,3,4) )
})
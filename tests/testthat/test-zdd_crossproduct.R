test_that("zdd_crossproduct works", {
  library(magrittr)
  zdd1 <- zdd(1L) | zdd(2L) | zdd(3L) | zdd(4L) | zdd(5L)
  zdd2 <-           zdd(6L) | zdd(7L) | zdd(8L) | zdd(9L)
  zdd3 <- zdd(5L) | zdd(6L) | zdd(7L) | zdd(8L) | zdd(9L)

  expect_equal(  attr(zdd1*zdd2, 'count')  , 20L)
  expect_equal(
    cutsets( (zdd(1L)|zdd(2L)) * (zdd(3L)|zdd(4L)) ),
    list(c(1,3),
         c(2,3),
         c(1,4),
         c(2,4))
  )
})

test_that("zdd_union works", {
  expec   <- list( c(3L) , c(4L) )
  result1 <- cutsets( zdd_union(as_zdd(4L) , as_zdd(3L) ) )
  result2 <- cutsets( zdd_union(as_zdd(3L) , as_zdd(4L) ) )
  result3 <- cutsets(           as_zdd(3L) | as_zdd(4L)  )
  expect_equal(expec, result1)
  expect_equal(expec, result2)
  expect_equal(expec, result3)

  library(magrittr)
  zdd345 <-
    zdd(3L, zdd0(), zdd1()) %>%
    zdd(4L, zdd0(), .     ) %>%
    zdd(5L, zdd0(), .     )
  zdd35  <-
    zdd(3L, zdd0(), zdd1()) %>%
    zdd(5L, zdd0(), .     )
  zdd45  <-
    zdd(4L, zdd0(), zdd1()) %>%
    zdd(5L, zdd0(), .     )
  zdd34  <-
    zdd(3L, zdd0(), zdd1()) %>%
    zdd(4L, zdd0(), .     )

  cutsets(zdd345)         %>% expect_equal( list( c(3L,4L,5L)) )
  cutsets(zdd35)          %>% expect_equal( list( c(3L,   5L)) )
  cutsets(zdd45)          %>% expect_equal( list( c(   4L,5L)) )
  cutsets(zdd34)          %>% expect_equal( list( c(3L,4L   )) )
  cutsets(zdd345 | zdd35) %>% expect_equal( list( c(3L,   5L)) )
  cutsets(zdd345 | zdd45) %>% expect_equal( list( c(   4L,5L)) )
  cutsets(zdd345 | zdd34) %>% expect_equal( list( c(3L,4L   )) )
  #cutsets(zdd345 | 3L ) %>% expect_equal( list( c(3L)) )  #this test not working yet
})

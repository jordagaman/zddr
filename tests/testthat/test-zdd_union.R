test_that("zdd_union works", {
  expec   <- list( c(3L) , c(4L) )
  result1 <- cutsets( zdd_union(zdd(4L) , zdd(3L) ) )
  result2 <- cutsets( zdd_union(zdd(3L) , zdd(4L) ) )
  result3 <- cutsets(           zdd(3L) | zdd(4L)  )
  expect_equal(expec, result1)
  expect_equal(expec, result2)
  expect_equal(expec, result3)

  library(magrittr)
  zdd345 <- zdd_and(3,4,5)
  zdd35  <- zdd_and(3,  5)
  zdd45  <- zdd_and(  4,5)
  zdd34  <- zdd_and(3,4  )

  cutsets(zdd345)         %>% expect_equal( list( c(3L,4L,5L)) )
  cutsets(zdd35)          %>% expect_equal( list( c(3L,   5L)) )
  cutsets(zdd45)          %>% expect_equal( list( c(   4L,5L)) )
  cutsets(zdd34)          %>% expect_equal( list( c(3L,4L   )) )
  (zdd345 | zdd35)        %>% expect_equal(       zdd35        )
  (zdd345 | zdd45)        %>% expect_equal(       zdd45        )
  (zdd345 | zdd34)        %>% expect_equal(       zdd34        )

  (zdd345 | 3L )          %>% expect_equal(       zdd(3L)      )
  (zdd345 | zdd35 | 4L )  %>% expect_equal(       zdd35 | 4L   )

  # these cases systematically evaluate whether minimal cutsets can be found in union statements
  (zdd_and(1,2,3,4) | zdd_and(1,2) ) %>% expect_equal( zdd_and(1,2) )
  (zdd_and(1,2,3,4) | zdd_and(1,4) ) %>% expect_equal( zdd_and(1,4) )
  (zdd_and(1,2,3,4) | zdd_and(2,3) ) %>% expect_equal( zdd_and(2,3) )
  (zdd_and(1,2,3,4) | zdd_and(2,4) ) %>% expect_equal( zdd_and(2,4) )
  (zdd_and(1,2,3,4) | zdd_and(3,4) ) %>% expect_equal( zdd_and(3,4) )
  (zdd_and(1,2,3,4) | zdd_and(1,3) ) %>% expect_equal( zdd_and(1,3) )

  zdd_or(1,2,FALSE)   %>% expect_equal( zdd_or(1,2) )
  zdd_or(1,1)         %>% expect_equal( zdd(1)      )
  zdd_or(1,2,TRUE)    %>% is_one %>% expect_true
  zdd_or(TRUE,1,2)    %>% is_one %>% expect_true

  ( (zdd(1) | zdd_and(2,3)) | zdd(2) ) %>% expect_equal( zdd_or(1,2) ) # if you are not careful, this returns {1},{2},{2,4}

  (zdd_and(1,2) | zdd_and(1,3,4) | zdd_and(1,4,5,6,7) | zdd(6) ) %>%
    zddr:::zdd_minimum_order() %>%
    expect_equal(1L)
  (zdd_and(1,2) | zdd_and(1,3,4) | zdd_and(1,4,5,6,7) | zdd(6) ) %>%
    zddr:::zdd_maximum_order() %>%
    expect_equal(3L)

  ( zdd_and(1,3,4,5,6,7) | zdd_and(1,2,4,6,7,23) | zdd_and(1,2) ) %>%
    expect_equal(zdd_and(1,3,4,5,6,7) | zdd_and(1,2)  )

  list(c(1,3,4,5,6,7), c(1,2,4,6,7,23), c(1,2) ) %>% as_zdd %>%
    expect_equal(zdd_and(1,3,4,5,6,7) | zdd_and(1,2)  )
})

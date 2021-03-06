test_that("subset0 works", {
  expect_true(is_zero(zdd_subset0(zdd(2L), 2L)))
  expect_true(zdd_subset0(zdd(1L), 2L) == 1L)
  library(magrittr)
  zdd24  <- zdd_and(2,4)
  zdd135 <- zdd_and(1,3,5)

  zdd_subset0(zdd135 | zdd24 , 5L) %>% expect_equal( zdd24       )
  zdd_subset0(zdd135 | zdd24 , 3L) %>% expect_equal( zdd24       )
  zdd_subset0(zdd135 | zdd24 , 1L) %>% expect_equal( zdd24       )
  zdd_subset0(zdd135 | zdd24 , 4L) %>% expect_equal( zdd135      )
  zdd_subset0(zdd135 | zdd24 , 2L) %>% expect_equal( zdd135      )
  zdd_subset0(zdd135 | 6L    , 6L) %>% expect_equal( zdd135      )
  zdd_subset0(zdd135 | 6L    , 7L) %>% expect_equal( zdd135 | 6L )
})

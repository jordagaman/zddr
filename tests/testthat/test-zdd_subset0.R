test_that("subset0 works", {
  expect_true(is_zero(zdd_subset0(as_zdd(2L), 2L)))
  expect_true(zdd_subset0(as_zdd(1L), 2L) == 1L)
  library(magrittr)
  zdd24 <-
    zdd(2L, zdd0(), zdd1()) %>%
    zdd(4L, zdd0(), .     )
  zdd135 <-
    zdd(1L, zdd0(), zdd1()) %>%
    zdd(3L, zdd0(), .     ) %>%
    zdd(5L, zdd0(), .     )

  zdd_subset0(zdd135 | zdd24 , 5L) %>% expect_equal( zdd24       )
  zdd_subset0(zdd135 | zdd24 , 3L) %>% expect_equal( zdd24       )
  zdd_subset0(zdd135 | zdd24 , 1L) %>% expect_equal( zdd24       )
  zdd_subset0(zdd135 | zdd24 , 4L) %>% expect_equal( zdd135      )
  zdd_subset0(zdd135 | zdd24 , 2L) %>% expect_equal( zdd135      )
  zdd_subset0(zdd135 | 6L    , 6L) %>% expect_equal( zdd135      )
  zdd_subset0(zdd135 | 6L    , 7L) %>% expect_equal( zdd135 | 6L )
})

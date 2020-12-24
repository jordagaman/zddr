test_that("subset1 works", {
  expect_true(is_one(zdd_subset1(zdd(2L), 2L)))# ONE
  expect_true(is_zero(zdd_subset1(zdd(1L), 2L)))# ZERO
  library(magrittr)
  zdd24 <-
    zdd(2L, zdd0(), zdd1()) %>%
    zdd(4L, zdd0(), .     )
  zdd135 <-
    zdd(1L, zdd0(), zdd1()) %>%
    zdd(3L, zdd0(), .     ) %>%
    zdd(5L, zdd0(), .     )
  zdd13 <-
    zdd(1L, zdd0(), zdd1()) %>%
    zdd(3L, zdd0(), .     )
  zdd15 <-
    zdd(1L, zdd0(), zdd1()) %>%
    zdd(5L, zdd0(), .     )
  zdd35 <-
    zdd(3L, zdd0(), zdd1()) %>%
    zdd(5L, zdd0(), .     )

  ####
  # some basic tests to start
  ####
  zdd_subset1(zdd135, 5L) %>% expect_equal( zdd13  )
  zdd_subset1(zdd135, 4L) %>% expect_equal( zdd0() )
  zdd_subset1(zdd135, 3L) %>% expect_equal( zdd15  )

  ####
  # some tests on a more complex zdd
  ####
  zdd_subset1(zdd135 | zdd24     , 5L) %>% expect_equal( zdd13      )
  zdd_subset1(zdd135 | zdd24     , 4L) %>% expect_equal( zdd(2L)    )
  zdd_subset1(zdd135 | zdd24     , 3L) %>% expect_equal( zdd15      )
  zdd_subset1(zdd135 | zdd24     , 2L) %>% expect_equal( zdd(4L)    )
  zdd_subset1(zdd135 | zdd24     , 1L) %>% expect_equal( zdd35      )
  zdd_subset1(zdd135 | zdd(6L)   , 6L) %>% expect_equal( zdd1()     )
  zdd_subset1(zdd135 | zdd(6L)   , 7L) %>% expect_equal( zdd0()     )
})

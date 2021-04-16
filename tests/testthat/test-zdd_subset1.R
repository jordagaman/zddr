test_that("subset1 works", {
  expect_true(is_one(zdd_subset1(zdd(2L), 2L)))# ONE
  expect_true(is_zero(zdd_subset1(zdd(1L), 2L)))# ZERO
  library(magrittr)
  zdd24  <- zdd_and(2,4)
  zdd135 <- zdd_and(1,3,5)
  zdd13  <- zdd_and(1,3  )
  zdd15  <- zdd_and(1,  5)
  zdd35  <- zdd_and(3,  5)

  ####
  # some basic tests to start
  ####
  zdd_subset1(zdd135, 5L) %>% expect_equal( zdd13  )
  is_zero(zdd_subset1(zdd135, 4L)) %>% expect_true()
  zdd_subset1(zdd135, 3L) %>% expect_equal( zdd15  )

  ####
  # some tests on a more complex zdd
  ####
  zdd_subset1(zdd135 | zdd24     , 5L) %>% expect_equal( zdd13      )
  zdd_subset1(zdd135 | zdd24     , 4L) %>% expect_equal( zdd(2L)    )
  zdd_subset1(zdd135 | zdd24     , 3L) %>% expect_equal( zdd15      )
  zdd_subset1(zdd135 | zdd24     , 2L) %>% expect_equal( zdd(4L)    )
  zdd_subset1(zdd135 | zdd24     , 1L) %>% expect_equal( zdd35      )
  zdd_subset1(zdd135 | zdd(6L)   , 6L) %>% is_one  %>% expect_true()
  zdd_subset1(zdd135 | zdd(6L)   , 7L) %>% is_zero %>% expect_true()
})

test_that("subset1 works", {
  expect_true(is_one(zdd_subset1(as_zdd(2L), 2L)))# ONE
  expect_true(is_zero(zdd_subset1(as_zdd(1L), 2L)))# ZERO
  library(magrittr)
  zdd24 <-
    zdd(2L, zdd0(), zdd1()) %>%
    zdd(4L, zdd0(), .     )
  zdd135 <-
    zdd(1L, zdd0(), zdd1()) %>%
    zdd(3L, zdd0(), .     ) %>%
    zdd(5L, zdd0(), .     )

  expect_cutsets <- function(result, expectation) {
    expect_equal(
      cutsets(result),
      expectation
    )
  }
  ####
  # some basic tests to start
  ####
  zdd_subset1(zdd135, 5L) %>% expect_cutsets( list( c(1L,3L) ) )
  zdd_subset1(zdd135, 4L) %>% expect_cutsets( list(          ) )
  zdd_subset1(zdd135, 3L) %>% expect_cutsets( list( c(1L,5L) ) )

  ####
  # some tests on a more complex zdd
  ####
  zdd_subset1(zdd135 | zdd24     , 5L) %>% expect_cutsets( list(c(1L,3L))    )
  zdd_subset1(zdd135 | zdd24     , 4L) %>% expect_cutsets( list(c(2L   ))    )
  zdd_subset1(zdd135 | zdd24     , 3L) %>% expect_cutsets( list(c(1L,5L))    )
  zdd_subset1(zdd135 | zdd24     , 2L) %>% expect_cutsets( list(c(4L   ))    )
  zdd_subset1(zdd135 | zdd24     , 1L) %>% expect_cutsets( list(c(3L,5L))    )
  zdd_subset1(zdd135 | as_zdd(6L), 6L) %>% expect_cutsets( list(  NULL  )    )
  zdd_subset1(zdd135 | as_zdd(6L), 7L) %>% expect_cutsets( list(        )    )
})

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

  expect_cutsets <- function(result, expectation) {
    expect_equal(
      cutsets(result),
      expectation
    )
  }

  zdd_subset0(zdd135 | zdd24 , 5L) %>% expect_cutsets( list(  c(2L,4L)      ) )
  zdd_subset0(zdd135 | zdd24 , 3L) %>% expect_cutsets( list(  c(2L,4L)      ) )
  zdd_subset0(zdd135 | zdd24 , 1L) %>% expect_cutsets( list(  c(2L,4L)      ) )
  zdd_subset0(zdd135 | zdd24 , 4L) %>% expect_cutsets( list(c(1L,3L,5L)     ) )
  zdd_subset0(zdd135 | zdd24 , 2L) %>% expect_cutsets( list(c(1L,3L,5L)     ) )
  zdd_subset0(zdd135 | 6L    , 6L) %>% expect_cutsets( list(c(1L,3L,5L)     ) )
  zdd_subset0(zdd135 | 6L    , 7L) %>% expect_cutsets( list(c(1L,3L,5L),c(6)) )
})

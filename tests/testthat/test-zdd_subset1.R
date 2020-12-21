test_that("subset1 works", {
  expect_true(is_one(zdd_subset1(as_zdd(2L), 2L)))# ONE
  expect_true(zdd_subset1(as_zdd(2L), 1L) == as_zdd(2L))# {2}
  expect_true(is_zero(zdd_subset1(as_zdd(1L), 2L)))# ZERO
  library(magrittr)
  zdd345 <-
    zdd(3L, zdd0(), zdd1()) %>%
    zdd(4L, zdd0(), .     ) %>%
    zdd(5L, zdd0(), .     )
  expect_equal(
    cutsets(zdd_subset1(zdd345, 4L)),
    list(c(3L,5L))
  )# {3,5}
})

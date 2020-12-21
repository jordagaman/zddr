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
  )
  expect_equal(
    cutsets(zdd_subset1(zdd345, 5L)),
    list(c(3L,4L))
  )
  expect_equal(
    cutsets(zdd_subset1(zdd345, 3L)),
    list(c(4L,5L))
  )

  expect_equal(
    cutsets(zdd_subset1(zdd345 | as_zdd(6L), 5L)),
    list(c(3L,4L),c(6))
  )
  expect_equal(
    cutsets(zdd_subset1(zdd345 | as_zdd(6L), 6L)),
    list(NULL)
  )
  expect_equal(
    cutsets(zdd_subset1(zdd345 | as_zdd(6L), 7L)),
    list()
  )


})

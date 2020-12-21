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

  ####
  # some basic tests to start
  ####
  expect_equal(
    cutsets(zdd_subset1(zdd135, 5L)),     list(c(1L,3L))
  )
  expect_equal(
    cutsets(zdd_subset1(zdd135, 4L)),     list()
  )
  expect_equal(
    cutsets(zdd_subset1(zdd135, 3L)),     list(c(1L,5L))
  )

  ####
  # some tests on a more complex zdd
  ####
  expect_equal(
    cutsets(zdd_subset1(zdd135 | zdd24, 5L)),     list(c(1L,3L))
  )
  expect_equal(
    cutsets(zdd_subset1(zdd135 | zdd24, 4L)),     list(c(2L))
  )
  expect_equal(
    cutsets(zdd_subset1(zdd135 | zdd24, 3L)),     list(c(1L,5L))
  )
  expect_equal(
    cutsets(zdd_subset1(zdd135 | zdd24, 2L)),     list(c(4L))
  )
  expect_equal(
    cutsets(zdd_subset1(zdd135 | zdd24, 1L)),     list(c(3L,5L))
  )

  expect_equal(
    cutsets(zdd_subset1(zdd135 | as_zdd(6L), 6L)),     list(NULL)
  )
  expect_equal(
    cutsets(zdd_subset1(zdd135 | as_zdd(6L), 7L)),     list()
  )
  expect_equal(
    cutsets(zdd_subset1(zdd135 | as_zdd(6L) | as_zdd(7L), 7L)), list(NULL)
  )


})

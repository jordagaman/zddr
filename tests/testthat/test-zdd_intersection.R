test_that("intersection works", {
  library(magrittr)
  zdd345 <-
    zdd(3L, zdd0(), zdd1()) %>%
    zdd(4L, zdd0(), .     ) %>%
    zdd(5L, zdd0(), .     )
  zdd35  <-
    zdd(3L, zdd0(), zdd1()) %>%
    zdd(5L, zdd0(), .     )
  zdd45  <-
    zdd(4L, zdd0(), zdd1()) %>%
    zdd(5L, zdd0(), .     )
  zdd34  <-
    zdd(3L, zdd0(), zdd1()) %>%
    zdd(4L, zdd0(), .     )

  ( (zdd345 | zdd35) & (zdd34 | zdd35) ) %>% expect_equal( zdd35  )
  ( (zdd345 | zdd45) &  zdd345         ) %>% expect_equal( zdd345 )
  ( (zdd345 | zdd34) &  zdd35          ) %>% expect_equal( zdd0() )
})

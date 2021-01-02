test_that("intersection works", {
  library(magrittr)
  zdd345 <- zdd_and(3,4,5)
  zdd35  <- zdd_and(3,  5)
  zdd45  <- zdd_and(  4,5)
  zdd34  <- zdd_and(3,4  )

  ( (zdd345 | zdd35) & (zdd34 | zdd35) ) %>% expect_equal( zdd35  )
  ( (zdd345 | zdd(1)) &  zdd345        ) %>% expect_equal( zdd345 )
  ( (zdd345 | zdd34) &  zdd35          ) %>% expect_equal( zdd0() )
})

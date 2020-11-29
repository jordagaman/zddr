test_that("hashes still work", {
  expect_equal(
    zdd(1L, '420767073edd8b7097448d6c27bf5534', '420767073edd8b7097448d6c27bf5534'),
    'f0d67fd44b5d93fe4a7e2ab0478a3669'
  )
})

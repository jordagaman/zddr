
test_that("zddr cutsets match MFAULT example", {
  # Alt Calc using MFAULT
  # BNWL-2145
  # November 1977
  # https://www.osti.gov/servlets/purl/5254299
  # ======================
  # - Using Section 4.4 example fault tree (Figure 11) -- see
  #   excerpt in altcalc-support directory

  # sub-tree -------------
  a22 <- zdd_and(29, 31)
  a21 <- zdd_or(a22, 30, 32)
  a19 <- zdd_and(29, 30)
  a20 <- zdd_or(29, 31, 32)

  # top event ---------------
  a18 <- zdd_and(a19, a20, a21)

  # expectation ---------------
  # Expectation for the top event A18 is: { X29 X30 } as shown
  # on page 46

  MFAULT_cutsets <- zdd_and(29, 30)
  expect_equal(a18, MFAULT_cutsets)
})
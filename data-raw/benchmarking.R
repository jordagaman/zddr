######### BASELINE - TIBBLE MULTIPLICATION
start_time <- Sys.time()
tb<-tibble::tibble(
  a = list(c( 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,20)),
  b = list(c(21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40)),
  c = list(c(41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60)),
  d = list(c(61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80)),
  e = list(c(81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100))
) %>%
  tidyr::unnest(a) %>%
  tidyr::unnest(b) %>%
  tidyr::unnest(c) %>%
  tidyr::unnest(d) %>%
  tidyr::unnest(e)

######### PERFORMANCE STATS
Sys.time() - start_time  # Time difference of 4.831196 secs
pryr::object_size(tb)    # 128 MB



######### COMPARISON - ZDD MULTIPLICATION
library(zddr)
reset_zdd_store()
start_time <- Sys.time()
zddr:::zdd_count(
  zdd_or(   1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,20) *
    zdd_or(21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40) *
    zdd_or(41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60) *
    zdd_or(61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80) *
    zdd_or(81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100) | zdd(1)
) # [1] 3200000

######### PERFORMANCE STATS
Sys.time() - start_time            # Time difference of 2.008795 secs
pryr::object_size(zddr::zdd_store) # 210 kB
pryr::object_size(zddr::zdd_fxns)  # 308 kB



######### COMPARISON - ZDD REDUCTION
library(zddr)
reset_zdd_store()
start_time <- Sys.time()
zddr:::zdd_count(
  zdd_or(   1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,20) *
    zdd_or(21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40) *
    zdd_or(41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60) *
    zdd_or(61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80) *
    zdd_or(81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100) | zdd(1) | zdd(2)
) # [1] 2880002

######### PERFORMANCE STATS
Sys.time() - start_time            # Time difference of 33.33057 secs
pryr::object_size(zddr::zdd_store) # 910 kB
pryr::object_size(zddr::zdd_fxns)  # 4.39 MB


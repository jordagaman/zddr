library(magrittr)

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
    zdd_or(81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100)
) # [1] 3200000

######### PERFORMANCE STATS
Sys.time() - start_time            # Time difference of 2.008795 secs
pryr::object_size(zddr::zdd_store) # 205 kB
pryr::object_size(zddr::zdd_fxns)  # 254 kB




######### COMPARISON - ZDD REDUCTION - what happens when we minimize
library(zddr)
reset_zdd_store()
start_time <- Sys.time()
zddr:::zdd_count(
  zdd_or(   1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,20) *
    zdd_or(21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40) *
    zdd_or(41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60) *
    zdd_or(61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80) *
    zdd_or(81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100) | zdd(1)
) # [1] 3040001

######### PERFORMANCE STATS
Sys.time() - start_time            # Time difference of 9.531208 secs
pryr::object_size(zddr::zdd_store) # 480 kB
pryr::object_size(zddr::zdd_fxns)  # 1.17 MB




######### COMPARISON - ZDD REDUCTION x2 - minimize by a second variable
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
Sys.time() - start_time            # Time difference of 15.4015 secs
pryr::object_size(zddr::zdd_store) # 628 kB
pryr::object_size(zddr::zdd_fxns)  # 2.22 MB




######### COMPARISON - ZDD REDUCTION x3 - minimize by a higher ranked variable
library(zddr)
reset_zdd_store()
start_time <- Sys.time()
zddr:::zdd_count(
  zdd_or(   1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,20) *
    zdd_or(21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40) *
    zdd_or(41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60) *
    zdd_or(61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80) *
    zdd_or(81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100) | zdd(50)
) # [1] 3040001

######### PERFORMANCE STATS
Sys.time() - start_time            # Time difference of 4.089529 secs
pryr::object_size(zddr::zdd_store) # 309 kB
pryr::object_size(zddr::zdd_fxns)  # 673 kB




######### COMPARISON - ZDD REDUCTION x3 - minimize by the highest variable
library(zddr)
reset_zdd_store()
start_time <- Sys.time()
zddr:::zdd_count(
  zdd_or(   1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,20) *
    zdd_or(21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40) *
    zdd_or(41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60) *
    zdd_or(61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80) *
    zdd_or(81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100) | zdd(100)
) # [1] 3040001

######### PERFORMANCE STATS
Sys.time() - start_time            # Time difference of 1.477556 secs
pryr::object_size(zddr::zdd_store) # 210 kB
pryr::object_size(zddr::zdd_fxns)  # 291 kB




######### GETTING GREEDY
library(zddr)
reset_zdd_store()
start_time <- Sys.time()
zddr:::zdd_count(
  zdd_or(   1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,20) *
    zdd_or(21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40) *
    zdd_or(41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60) *
    zdd_or(61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80) *
    zdd_or(81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100) *
    zdd_or(101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120)
) # [1] 64000000

######### PERFORMANCE STATS
Sys.time() - start_time            # Time difference of 2.008795 secs
pryr::object_size(zddr::zdd_store) # 263 kB
pryr::object_size(zddr::zdd_fxns)  # 453 kB




######### GETTING GREEDY - reorder multiplication statements
library(zddr)
reset_zdd_store()
start_time <- Sys.time()
zddr:::zdd_count(
  zdd_or(101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120) *
    zdd_or(81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100) *
    zdd_or(61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80) *
    zdd_or(41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60) *
    zdd_or(21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40) *
    zdd_or(   1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,20)
) # [1] 64,000,000

######### PERFORMANCE STATS
Sys.time() - start_time            # Time difference of 4.074686 secs
pryr::object_size(zddr::zdd_store) # 405 kB
pryr::object_size(zddr::zdd_fxns)  # 782 kB




######### COMPARISON - GREEDY ZDD MULTIPLICATION with a single minimal addition
library(zddr)
reset_zdd_store()
start_time <- Sys.time()
zddr:::zdd_count(
  (zdd_or(   1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,20) *
     zdd_or(21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40) *
     zdd_or(41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60) *
     zdd_or(61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80) *
     zdd_or(81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100) *
     zdd_or(101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120)) |
    zdd_and(61, 71)
) # [1] 64000001

######### PERFORMANCE STATS
Sys.time() - start_time            # Time difference of 3.2359 secs
pryr::object_size(zddr::zdd_store) # 301 kB
pryr::object_size(zddr::zdd_fxns)  # 576 kB




######### COMPARISON - GREEDY ZDD MULTIPLICATION with a single nonminimal addition
library(zddr)
reset_zdd_store()
start_time <- Sys.time()
zddr:::zdd_count(
  (zdd_or(   1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,20) *
     zdd_or(21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40) *
     zdd_or(41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60) *
     zdd_or(61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80) *
     zdd_or(81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100) *
     zdd_or(101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120)) |
    zdd_and(41,81)
) # [1] 63,840,0001  (which is right, 20^6 - 20^4 +1 = 64,000,000 - 160,000 + 1)

######### PERFORMANCE STATS
Sys.time() - start_time            # Time difference of 10.14345 secs
pryr::object_size(zddr::zdd_store) # 398 kB
pryr::object_size(zddr::zdd_fxns)  # 1.12 MB




######### COMPARISON - GREEDY ZDD MULTIPLICATION with a multiple nonminimal additions
library(zddr)
reset_zdd_store()
start_time <- Sys.time()
zddr:::zdd_count(
  (zdd_or(   1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,20) *
     zdd_or(21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40) *
     zdd_or(41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60) *
     zdd_or(61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80) *
     zdd_or(81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100) *
     zdd_or(101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120)) |
    zdd_and(41,81) | zdd_and(28,88)
) # [1] 63,680,002  (which is right, 20^6 - 2*20^4 +2 = 64,000,000 - 320,000 + 2)

######### PERFORMANCE STATS
Sys.time() - start_time            # Time difference of 43.60355 secs
pryr::object_size(zddr::zdd_store) # 1.07 MB
pryr::object_size(zddr::zdd_fxns)  # 6.18 MB



######### COMPARISON - GREEDY ZDD MULTIPLICATION with a 10 nonminimal additions
library(zddr)
reset_zdd_store()
start_time <- Sys.time()
zddr:::zdd_count(
  (zdd_or(   1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,20) *
     zdd_or(21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40) *
     zdd_or(41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60) *
     zdd_or(61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80) *
     zdd_or(81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100) *
     zdd_or(101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120)) |
    zdd_and(41,81) | zdd_and(28,88) | zdd_and(29, 107) | zdd_and(21,101) | zdd_and(23,83)
) # [1] 63,200,805

######### PERFORMANCE STATS
Sys.time() - start_time            # Time difference of 16.01262 mins
pryr::object_size(zddr::zdd_store) # 18.8 MB
pryr::object_size(zddr::zdd_fxns)  # 109 MB

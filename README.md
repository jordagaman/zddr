
<!-- README.md is generated from README.Rmd. Please edit that file -->

# zddr

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/jordagaman/zddr.svg?branch=main)](https://travis-ci.com/jordagaman/zddr)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R build
status](https://github.com/jordagaman/zddr/workflows/R-CMD-check/badge.svg)](https://github.com/jordagaman/zddr/actions)
[![Codecov test
coverage](https://codecov.io/gh/jordagaman/zddr/branch/main/graph/badge.svg)](https://codecov.io/gh/jordagaman/zddr?branch=main)
<!-- badges: end -->

The goal of `zddr` is to enable definition, manipulation, and solving of
fault tree problems using an implementation of [zero-suppressed binary
decision
diagram](https://en.wikipedia.org/wiki/Zero-suppressed_decision_diagram)
algorithms in R.

## Installation

<!--
You can install the released version of zddr from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("zddr")
```
-->

Install the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("jordagaman/zddr")
```

## Example

This is a simple cutset.

``` r
library(zddr)
zdd(1) * zdd(2) * zdd(3)
#> Registered S3 method overwritten by 'pryr':
#>   method      from
#>   print.bytes Rcpp
#> Memory of ZDD Store:     0.008 MB, item count: 7 ( 1.14 KB/item)
#> Memory of ZDD Functions: 0.003 MB, item count: 13 ( 0.23 KB/item)
#> d669df34342e40b977d48fbd7e725243 : 1 cutsets, min order: 3 max order: 3 
#> 3-order 
#>       1 
#> {1,2,3}
```

You can create the same cutset above with a simpler call:

``` r
zdd_and(1, 2, 3)
#> Memory of ZDD Store:     0.008 MB, item count: 7 ( 1.14 KB/item)
#> Memory of ZDD Functions: 0.005 MB, item count: 22 ( 0.23 KB/item)
#> d669df34342e40b977d48fbd7e725243 : 1 cutsets, min order: 3 max order: 3 
#> 3-order 
#>       1 
#> {1,2,3}
```

Multiple cutsets look like this:

``` r
zdd_and(1, 2, 3) | zdd_and(4, 5) | zdd(6)
#> Memory of ZDD Store:     0.014 MB, item count: 13 ( 1.08 KB/item)
#> Memory of ZDD Functions: 0.008 MB, item count: 37 ( 0.22 KB/item)
#> 17c4ddfd5601bfe04f5c14f01d1b4fd4 : 3 cutsets, min order: 1 max order: 3 
#> 1-order 2-order 3-order 
#>       1       1       1 
#> {1,2,3}, {4,5}, {6}
```

The real magic is ensuring that when you add a new cutset, you check if
either that one or the existing ones are nonminimal. For example,
`{1,2,3}` is nonminimal to `{1}`. Check this out:

``` r
zdd_and(1, 2, 3) | zdd_and(4, 5) | zdd(6) | zdd(1)
#> Memory of ZDD Store:     0.016 MB, item count: 15 ( 1.07 KB/item)
#> Memory of ZDD Functions: 0.012 MB, item count: 62 ( 0.19 KB/item)
#> 6bd5786cfd76ff927f06820c0b856a25 : 3 cutsets, min order: 1 max order: 2 
#> 1-order 2-order 
#>       2       1 
#> {1}, {4,5}, {6}
```

## Longer-term vision

This package is in a developmental state. The ultimate dream is to
simplify the user interface using the increasingly robust `as_zdd()`
function.

The most basic use of `as_zdd()` accepts numeric and integer inputs.

``` r
as_zdd(10)
#> Memory of ZDD Store:     0.017 MB, item count: 16 ( 1.06 KB/item)
#> Memory of ZDD Functions: 0.012 MB, item count: 62 ( 0.19 KB/item)
#> 3fe2ac99b730ddf1f8240994344c9a49 : 1 cutsets, min order: 1 max order: 1 
#> 1-order 
#>       1 
#> {10}
as_zdd(10L)
#> Memory of ZDD Store:     0.017 MB, item count: 16 ( 1.06 KB/item)
#> Memory of ZDD Functions: 0.012 MB, item count: 63 ( 0.19 KB/item)
#> 3fe2ac99b730ddf1f8240994344c9a49 : 1 cutsets, min order: 1 max order: 1 
#> 1-order 
#>       1 
#> {10}
```

The function also assumes that vectors are meant to represent a cutset.

``` r
as_zdd( c(1,2,3) )
#> Memory of ZDD Store:     0.017 MB, item count: 16 ( 1.06 KB/item)
#> Memory of ZDD Functions: 0.014 MB, item count: 71 ( 0.2 KB/item)
#> d669df34342e40b977d48fbd7e725243 : 1 cutsets, min order: 3 max order: 3 
#> 3-order 
#>       1 
#> {1,2,3}
```

And lists are meant to represent a collection of cutsets.

``` r
as_zdd( list(1,2,3) )
#> Memory of ZDD Store:     0.019 MB, item count: 18 ( 1.06 KB/item)
#> Memory of ZDD Functions: 0.015 MB, item count: 78 ( 0.19 KB/item)
#> 8734bc46920d7528a4b26fa2c034857e : 3 cutsets, min order: 1 max order: 1 
#> 1-order 
#>       3 
#> {1}, {2}, {3}
```

One can combine the two to produce a ZDD representation of cutsets. The
final example from the last section is reproduced here using only base R
types and the `as_zdd()` function.

``` r
lst <- list(
  c(1,2,3),
  c(4,5),
  6,
  1
)
as_zdd(lst)
#> Memory of ZDD Store:     0.019 MB, item count: 18 ( 1.06 KB/item)
#> Memory of ZDD Functions: 0.02 MB, item count: 108 ( 0.19 KB/item)
#> 6bd5786cfd76ff927f06820c0b856a25 : 3 cutsets, min order: 1 max order: 2 
#> 1-order 2-order 
#>       2       1 
#> {1}, {4,5}, {6}
```

There are two effects to the above. First, it enables a complete round
trip between base R cutsets and ZDDs.

``` r
z <- as_zdd(lst)
cutsets(z)
#> [[1]]
#> [1] 1
#> 
#> [[2]]
#> [1] 4 5
#> 
#> [[3]]
#> [1] 6
cutsets( as_zdd(cutsets(z)) )
#> [[1]]
#> [1] 1
#> 
#> [[2]]
#> [1] 4 5
#> 
#> [[3]]
#> [1] 6
```

Second, it enables quick generation and then manipulation of ZDDs
without having to know too much about the internals of the `zddr`
implementation.

``` r
z * list(1, c(2,3), 4)
#> Memory of ZDD Store:     0.025 MB, item count: 23 ( 1.09 KB/item)
#> Memory of ZDD Functions: 0.026 MB, item count: 137 ( 0.19 KB/item)
#> 2e37313d5b9ac940767ef56a332722f8 : 4 cutsets, min order: 1 max order: 3 
#> 1-order 2-order 3-order 
#>       1       2       1 
#> {1}, {4,5}, {2,3,6}, {4,6}
```

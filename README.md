
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
coverage](https://codecov.io/gh/jordagaman/zddr/branch/master/graph/badge.svg)](https://codecov.io/gh/jordagaman/zddr?branch=master)
<!-- badges: end -->

The goal of zddr is to …

## Installation

You can install the released version of zddr from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("zddr")
```

And the development version from [GitHub](https://github.com/) with:

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
#> Memory of ZDD Store:     0.005 MB, item count: 7 
#> Memory of ZDD Functions: 0.005 MB, item count: 13 
#> d669df34342e40b977d48fbd7e725243 : 1 cutsets
#> { 1 2 3 }
```

You can create the same cutset above with a simpler call:

``` r
library(zddr)
zdd_and(1, 2, 3)
#> Memory of ZDD Store:     0.005 MB, item count: 7 
#> Memory of ZDD Functions: 0.008 MB, item count: 22 
#> d669df34342e40b977d48fbd7e725243 : 1 cutsets
#> { 1 2 3 }
```

Multiple cutsets look like this:

``` r
library(zddr)
zdd_and(1, 2, 3) | zdd_and(4, 5) | zdd(6)
#> Memory of ZDD Store:     0.011 MB, item count: 14 
#> Memory of ZDD Functions: 0.015 MB, item count: 42 
#> 17c4ddfd5601bfe04f5c14f01d1b4fd4 : 3 cutsets
#> { 1 2 3 } 
#> { 4 5 } 
#> { 6 }
```

The real magic is ensuring that when you add a new cutset, you check if
either that one or the existing ones are nonminimal. For example,
{1,2,3} is nonminimal to {1}. Check this out:

``` r
library(zddr)
zdd_and(1, 2, 3) | zdd_and(4, 5) | zdd(6) | zdd(1)
#> Memory of ZDD Store:     0.013 MB, item count: 17 
#> Memory of ZDD Functions: 0.026 MB, item count: 75 
#> 6bd5786cfd76ff927f06820c0b856a25 : 3 cutsets
#> { 1 } 
#> { 4 5 } 
#> { 6 }
```

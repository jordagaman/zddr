% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/zdd_subset1.R
\name{zdd_subset1}
\alias{zdd_subset1}
\title{zdd_subset1}
\usage{
zdd_subset1(zdd, value)
}
\arguments{
\item{zdd}{a zdd list object}

\item{value}{a value}
}
\value{
the subset of zdd such as value = TRUE
}
\description{
zdd_subset1
}
\examples{
zdd_subset1(zdd(2L), 2L)# ONE
zdd_subset1(zdd(2L), 1L)# {2}
zdd_subset1(zdd(1L), 2L)# ZERO
zdd_subset1(zdd_and(3,4,5), 4L)   # {3,5}
}

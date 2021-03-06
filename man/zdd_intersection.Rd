% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/zdd_intersection.R
\name{zdd_intersection}
\alias{zdd_intersection}
\title{zdd_intersection}
\usage{
zdd_intersection(zddP, zddQ)
}
\arguments{
\item{zddP}{a zdd list object}

\item{zddQ}{a zdd list object}
}
\value{
a zdd list object that is the intersection of the two input zdds
}
\description{
zdd_intersection
}
\examples{
zdd(2L) | zdd(3L) & zdd(3L)   # { {2}, {3} }
(zdd(2L) | zdd(3L)) & zdd(3L) # {   {3}    }
}

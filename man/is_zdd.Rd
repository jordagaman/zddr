% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/is_zdd.R
\name{is_zdd}
\alias{is_zdd}
\title{is_zdd}
\usage{
is_zdd(zdd)
}
\arguments{
\item{zdd}{object}
}
\value{
TRUE if the object is the class of the zdd list object
}
\description{
is_zdd
}
\examples{
is_zdd(as_zdd(FALSE)) # TRUE
is_zdd(3L)     # FALSE
}

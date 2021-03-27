#' Coerce an integer or string hash to a ZDD object
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' `as_zdd()` turns an existing object, such as a numeric/integer value or a
#' string that corresponds to a previously created ZDD, into a registered ZDD
#' object of class `zdd`.
#'
#' @param x the integer value of the node to be added or the string hash of the
#'     node to pull from the store
#'
#' @return the single variable elementary zdd (the so-called "set containing
#'    `value`")
#' @export
#'
#' @examples
#' as_zdd(3L)
#' as_zdd('d7281766b28bdc9025520edeeffecdd9')
#' #as_zdd('this one does not exist')  # this one throws an error
#'
as_zdd <- function(x) {
  UseMethod("as_zdd")
}

#' @export
#' @rdname as_zdd
as_zdd.zdd <- function(x) {
  return(x)
}

#' @export
#' @rdname as_zdd
as_zdd.integer <- function(x) {
  if(length(x) > 1L) return(lzdd_and(x))
  return(zdd(x))
}

#' @export
#' @rdname as_zdd
as_zdd.list <- function(x) {
  return(lzdd_or(x))
}

#' @export
#' @rdname as_zdd
as_zdd.numeric <- function(x) {
  stopifnot(all.equal(x, as.integer(x)))
  if(length(x) > 1L) return(lzdd_and(x))
  return(zdd(x))
}

#' @export
#' @rdname as_zdd
as_zdd.character <- function(x) {
  if(!zdd_exists(x)) stop('hash not found in zdd_store')
  if(length(x) > 1L) return(lzdd_and(x))
  return(zddr::zdd_store[[x]])
}

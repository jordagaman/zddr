#' as_zdd
#'
#' @param x the integer value of the node to be added or the string hash of the node to pull from the store
#'
#' @return the single variable elementary zdd (the so-called "set containing `value`")
#' @export
#'
#' @examples
#' as_zdd(3L)
#' as_zdd('d7281766b28bdc9025520edeeffecdd9')
#' #as_zdd('this one does not exist')  # this one throws an error
as_zdd <- function(x) {
  UseMethod("as_zdd")
}

#' @export
as_zdd.zdd <- function(x) {
  return(x)
}

#' @export
as_zdd.integer <- function(x) {
  return(zdd(x))
}

#' @export
as_zdd.numeric <- function(x) {
  stopifnot(all.equal(x, as.integer(x)))
  return(zdd(x))
}

#' @export
as_zdd.character <- function(x) {
  if(!zdd_exists(x)) stop('hash not found in zdd_store')
  return(zddr::zdd_store[[x]])
}

#' @export
as_zdd.raw <- function(x) {
  zdd <- paste0(as.character(x), collapse = '')
  if(!zdd_exists(zdd)) stop('hash not found in zdd_store')
  return(zddr::zdd_store[[zdd]])
}

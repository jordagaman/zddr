#' zdd
#'
#' @param value the integer value of the node
#' @param p0 the negative compliment of the zdd with respect to `value`, expressed as a string hash or as class zdd
#' @param p1 the positive compliment of the zdd with respect to `value`, expressed as a string hash or as class zdd
#'
#' @return the resulting zdd node, expressed as class zdd
#' @export
#'
#' @examples
#' zdd(1L, '420767073edd8b7097448d6c27bf5534', '420767073edd8b7097448d6c27bf5534')
zdd <- function(value, p0, p1) {
  P0 <- ifelse(is_zdd(p0), p0$hash, p0)
  P1 <- ifelse(is_zdd(p1), p1$hash, p1)
  hash <- zdd_hash(value, P0, P1)
  if(!exists(hash, envir = zddr::zdd_store))
    assign(
      x     = hash,
      value = list(value = value, p0 = P0, p1 = P1, hash = hash),
      envir = zddr::zdd_store
    )
  res <- as_zdd(hash)
  class(res) <- "zdd"
  return(res)
}


#' zdd hash
#'
#' @param value the integer value of the node
#' @param p0 the negative compliment of the zdd with respect to `value`, expressed as class zdd
#' @param p1 the positive compliment of the zdd with respect to `value`, expressed as class zdd
#'
#' @return hash
#'
#' @examples
#' zdd(1L, '420767073edd8b7097448d6c27bf5534', '420767073edd8b7097448d6c27bf5534')
zdd_hash <- function(value, p0, p1) {
  if(!is.integer(value))
    stop('value must be an integer')
  if(value < 0)
    stop('value must not be negative')
  if(!(is.character(p0)&is.character(p1)))
    stop('p0 and p1 must be strings')
  digest::digest(
    object = list(value, p0, p1),
    raw    = FALSE
  )
}

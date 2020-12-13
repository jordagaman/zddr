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
#' zdd(1L, zdd0(), zdd1())
zdd <- function(value, p0, p1) {
  P0 <- ifelse(is_zdd(p0), p0$hash, p0)
  P1 <- ifelse(is_zdd(p1), p1$hash, p1)
  hash <- zdd_hash(value, P0, P1)
  res  <- list(value = value, p0 = P0, p1 = P1, hash = hash)
  class(res) <- "zdd"
  if(!exists(hash, envir = zddr::zdd_store))
    assign(
      x     = hash,
      value = res,
      envir = zddr::zdd_store
    )
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
#' zddr:::zdd_hash(1L, zdd0()$hash, zdd1()$hash)
zdd_hash <- function(value, p0, p1) {
  if(!is.integer(value))
    stop('value must be an integer')
  if(value < 0)
    stop('value must not be negative')
  if(!exists(p0, envir = zddr::zdd_store))
    stop('p0 must be a registered zdd node')
  if(!exists(p1, envir = zddr::zdd_store))
    stop('p1 must be a registered zdd node')
  digest::digest(
    object = list(value, p0, p1),
    raw    = FALSE
  )
}

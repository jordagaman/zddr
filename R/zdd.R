#' zdd
#'
#' @param value the integer value of the node
#' @param p0 the negative compliment of the zdd with respect to `value`, expressed as class zdd
#' @param p1 the positive compliment of the zdd with respect to `value`, expressed as class zdd
#'
#' @return the resulting zdd node, expressed as class zdd
#' @export
#'
#' @examples
zdd <- function(value, p0, p1) {
  hash <- zdd_hash(value, p0, p1)
  if(!exists('zdd_store'))
    zdd_store <- new.env(parent = emptyenv())
  if(!exists(hash, envir = 'zdd_store'))
    assign(
      x = hash,
      value = list(value = value, p0 = p0, p1 = p1)
    )
  return(hash)
}


#' zdd hash
#'
#' @param value the integer value of the node
#' @param p0 the negative compliment of the zdd with respect to `value`, expressed as class zdd
#' @param p1 the positive compliment of the zdd with respect to `value`, expressed as class zdd
#'
#' @return hash
#' @export
#'
#' @examples
zdd_hash <- function(value, p0, p1) {
  if(!is.integer(value))
    stop('value must be an integer')
  if(!(is.character(p0)&is.character(p1)))
    stop('p0 and p1 must be strings')
  digest::digest(
    object = list(value, p0, p1),
    raw    = FALSE
  )
}

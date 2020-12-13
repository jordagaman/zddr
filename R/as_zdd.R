#' as_zdd
#'
#' @param value the integer value of the node to be added
#'
#' @return the single variable elementary zdd (the so-called "set containing `value`")
#' @export
#'
#' @examples as_zdd(3L)
#' as_zdd('aeca5759d5d7a2fca7544cd6baba7bd5')
#' as_zdd('this one does not exist')
as_zdd <- function(x) {
  UseMethod("as_zdd")
}

#' @export
as_zdd.integer <- function(value) {
  zdd(
    value = value,
    p0    = zdd0()$hash,
    p1    = zdd1()$hash
  )
}

#' @export
as_zdd.character <- function(hash) {
  if(!exists(hash, envir = zddr::zdd_store))
    stop('hash not found in zdd_store')
  get(hash, envir = zddr::zdd_store)
}

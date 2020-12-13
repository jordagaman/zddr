#' as_zdd
#'
#' @param x the integer value of the node to be added or the string hash of the node to pull from the store
#'
#' @return the single variable elementary zdd (the so-called "set containing `value`")
#' @export
#'
#' @examples
#' as_zdd(3L)
#' as_zdd('aeca5759d5d7a2fca7544cd6baba7bd5')
#' #as_zdd('this one does not exist')  # this one throws an error
as_zdd <- function(x) {
  UseMethod("as_zdd")
}

#' @export
as_zdd.integer <- function(x) {
  zdd(
    value = x,
    p0    = zdd0(),
    p1    = zdd1()
  )
}

#' @export
as_zdd.character <- function(x) {
  if(!exists(x, envir = zddr::zdd_store))
    stop('hash not found in zdd_store')
  get(x, envir = zddr::zdd_store)
}

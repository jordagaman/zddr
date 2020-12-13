#' as_zdd
#'
#' @param value the integer value of the node to be added
#'
#' @return the single variable elementary zdd (the so-called "set containing `value`")
#' @export
#'
#' @examples as_zdd(3L)
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

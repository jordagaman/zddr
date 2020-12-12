#' zdd1
#'
#' @return the constant-1 elementary zdd (the so-called "set containing the empty set")
#' @export
#'
#' @examples zdd1()
zdd1 <- function() {
  zdd(
    value = 1L,
    p0    = '',
    p1    = ''
  )
}

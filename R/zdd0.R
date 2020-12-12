#' zdd0
#'
#' @return the constant-0 elementary zdd (the so-called "empty set")
#' @export
#'
#' @examples zdd0()
zdd0 <- function() {
  zdd(
    value = 0L,
    p0    = '',
    p1    = ''
  )
}

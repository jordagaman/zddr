#' is_zero
#'
#' @param zdd a zdd list object
#'
#' @return TRUE if the zdd matches the output of zdd0()
#' @export
#'
#' @examples
#' is_zero(zdd0())     # TRUE
#' is_zero(as_zdd(0L)) # FALSE
is_zero <- function(zdd) {
  return(as.character(zdd) == as.character(zdd0()))
}

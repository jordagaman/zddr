#' iz_zdd
#'
#' @param zdd object
#'
#' @return TRUE if the object is the class of the zdd list object
#' @export
#'
#' @examples
#' is_zdd(zdd0()) # TRUE
#' is_zdd(3L)     # FALSE
is_zdd <- function(zdd) {
  return(class(zdd) == 'zdd')
}

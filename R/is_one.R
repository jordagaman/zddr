#' is_one
#'
#' @param zdd a zdd list object
#'
#' @return TRUE if the zdd matches the output of zdd1()
#' @export
#'
#' @examples
#' is_one(zdd1())     # TRUE
#' is_one(zdd(1L))    # FALSE
is_one <- function(zdd) {
  return(zdd == zdd1())
}

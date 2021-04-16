#' is_one
#'
#' @param zdd a zdd list object
#'
#' @return TRUE if the zdd matches the output of zdd1()
#' @export
#'
#' @examples
#' is_one(as_zdd(TRUE))  # TRUE
#' is_one(zdd(1L))    # FALSE
is_one <- function(zdd) {
  return(zdd == zdd1())
}


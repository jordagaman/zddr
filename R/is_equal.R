#' is_equal
#'
#' @param zddP a zdd in the zdd_store
#' @param zddQ a zdd in the zdd_store
#'
#' @return TRUE if the input zdd's are equal
#' @export
#'
#' @examples
#' is_equal(as_zdd(1L), as_zdd(1L)) # TRUE
is_equal <- function(zddP, zddQ) {
  return(as.character(zddP) == as.character(zddQ))
}

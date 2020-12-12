#' get_zdd
#'
#' @param hash name of the zdd in the zdd_store
#'
#' @return zdd list object
#' @export
#'
#' @examples get_zdd(as_zdd(3L)$hash)
get_zdd <- function(hash) {
  get(hash, envir = zddr::zdd_store)
}

#' zdd1
#'
#' @return the constant-1 elementary zdd (the so-called "set containing the empty set")
#' @export
#'
#' @examples zdd1()
zdd1 <- function() {
  hash <- 'ffffffffffffffffffffffffffffffff'
  res <- list(hash = hash)
  class(res) <- "zdd"
  if(!zdd_exists(res)) register_zdd(res)
  return(res)
}

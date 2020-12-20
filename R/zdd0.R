#' zdd0
#'
#' @return the constant-0 elementary zdd (the so-called "empty set")
#' @export
#'
#' @examples zdd0()
zdd0 <- function() {
  hash <- '00000000000000000000000000000000'
  res <- list(hash = hash)
  class(res) <- "zdd"
  if(!zdd_exists(res)) register_zdd(res)
  return(res)
}

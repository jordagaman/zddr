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
  if(!exists(hash, envir = zddr::zdd_store))
    assign(
      x     = hash,
      value = res,
      envir = zddr::zdd_store
    )
  return(res)
}

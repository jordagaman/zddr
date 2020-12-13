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
  if(!exists(hash, envir = zddr::zdd_store))
    assign(
      x     = hash,
      value = res,
      envir = zddr::zdd_store
    )
  return(res)
}

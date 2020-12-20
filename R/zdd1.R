#' zdd1
#'
#' @return the constant-1 elementary zdd (the so-called "set containing the empty set")
#' @export
#'
#' @examples zdd1()
zdd1 <- function() {
  return(
    terminal_node(hash = 'ffffffffffffffffffffffffffffffff')
  )
}

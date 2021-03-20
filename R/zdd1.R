#' zdd1
#'
#' @return the constant-1 elementary zdd (the so-called "set containing the empty set")
#' @export
#'
#' @examples zdd1()
zdd1 <- function() {
  return(
    terminal_node(hash = 'ffffffffffffffffffffffffffffffff',
                  order = 1L,
                  minimum_order = 0L,
                  maximum_order = 0L,
                  count = 1L)
  )
}

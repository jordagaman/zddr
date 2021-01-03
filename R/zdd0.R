#' zdd0
#'
#' @return the constant-0 elementary zdd (the so-called "empty set")
#' @export
#'
#' @examples zdd0()
zdd0 <- function() {
  return(
    terminal_node(hash = '00000000000000000000000000000000',
                  minimum_order = NULL,
                  maximum_order = NULL,
                  count = 0L)
  )
}

terminal_node <- function(hash, minimum_order, maximum_order, count) {
  res <- structure(.Data = hash,
                   class = 'zdd',
                   minimum_order = minimum_order,
                   maximum_order = maximum_order,
                   count = as.integer(count))
  if(!zdd_exists(res)) register_zdd(res)
  return(res)
}

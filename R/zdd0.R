#' zdd0
#'
#' @return the constant-0 elementary zdd (the so-called "empty set")
#' @export
#'
#' @examples zdd0()
zdd0 <- function() {
  return(
    terminal_node(hash = '00000000000000000000000000000000',
                  order = c(),
                  minimum_order = NULL,
                  maximum_order = NULL,
                  count = 0L)
  )
}

terminal_node <- function(hash, order, minimum_order, maximum_order, count) {
  res <- structure(.Data = hash,
                   class = 'zdd',
                   order = order,
                   minimum_order = minimum_order,
                   maximum_order = maximum_order,
                   count = as.integer(count))
  if(!zdd_exists(res)) register_zdd(res)
  return(res)
}

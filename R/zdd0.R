#' zdd0
#'
#' @return the constant-0 elementary zdd (the so-called "empty set")
#' @export
#'
#' @examples zdd0()
zdd0 <- function() {
  return(
    terminal_node(hash = '00000000000000000000000000000000',
                  count = 0L)
  )
}

terminal_node <- function(hash, count) {
  res <- structure(.Data = hash,
                   class = 'zdd',
                   count = as.integer(count))
  if(!zdd_exists(res)) register_zdd(res)
  return(res)
}

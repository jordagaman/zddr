#' zdd0
#'
#' @return the constant-0 elementary zdd (the so-called "empty set")
#' @export
#'
#' @examples zdd0()
zdd0 <- function() {
  return(
    terminal_node(hash = '00000000000000000000000000000000')
  )
}

terminal_node <- function(hash) {
  res <- structure(.Data = list(hash = hash),
                   class = 'zdd')
  if(!zdd_exists(res)) register_zdd(res)
  return(res)
}

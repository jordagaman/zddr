#' protect
#'
#' @param x the ZDD to protect, including subnodes
#'
#' @return the ZDD, protected
#' @export
#'
#' @examples
#' a <- as_zdd(list(c(1,2,3), 4, c(5,6)))
#' protect(a)
#' reset_zdd_store(keep_protected = TRUE) # preserves the protected ZDD assigned to `a`
protect <- function(x) {
  UseMethod("protect")
}

#' @export
#' @rdname protect
protect.zdd <- function(x) {
  if(zdd_protected(x))
    return(x)
  p0 <- protect(p0(x))
  p1 <- protect(p1(x))
  attr(x, 'protected') <- TRUE
  register_zdd(x)
  return(x)
}

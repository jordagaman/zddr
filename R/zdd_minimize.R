#' zdd_minimize
#'
#' @param zdd a zdd object
#' @param Q   a NULL object - nothing is done with this input, a refactor should be performed at some point to remove it
#'
#' @return a zdd object that contains only minimal solutions
#' @export
#'
zdd_minimize <- function(zdd, Q = NULL) {
  P <- as_zdd(zdd)
  if( is_zero(P) ) return(  P  )
  if(  is_one(P) ) return(  P  )
  return(
    zdd(value = P,
        p0    = zmin( p0(P) ),
        p1    = zmin( p1(P) ) %% p0(P) )
  )
}

zmin.zdd <- function(a, na.rm = FALSE) zdd_binary_function(a, 'zdd_minimize', '')

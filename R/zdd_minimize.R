#' zdd_minimize
#'
#' @param zdd a zdd object
#'
#' @return a zdd object that has only minimal solutions
#' @export
#'
#' @examples
#' zdd(2L) | zdd(3L) & zdd(3L)   # { {2}, {3} }
#' (zdd(2L) | zdd(3L)) & zdd(3L) # {   {3}    }
zdd_minimize <- function(zdd, Q = NULL) {
  P <- as_zdd(zdd)
  if( is_zero(P) ) return(  P  )
  if(  is_one(P) ) return(  P  )
  return(
    zdd(value = P,
        p0    = min( p0(P) ),
        p1    = min( p1(P) ) %% p0(P) )
  )
}

#' @export
min.zdd <- function(a, na.rm = FALSE) zdd_binary_function(a, 'zdd_minimize', '')

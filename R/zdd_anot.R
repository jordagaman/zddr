#' zdd_anot
#'
#' @param zddP a zdd list object
#' @param zddQ a zdd list object
#'
#' @return a zdd list object that is the elements of the first object that are nonminimal to the second
#' @export
#'
#' @examples
#' cutsets( (zdd(3) | zdd(4)) %anot% zdd(4))
#' cutsets( (zdd(3) * zdd(4)) %anot% zdd(4))
zdd_anot <- function(zddP, zddQ) {
  P <- as_zdd(zddP)
  Q <- as_zdd(zddQ)
  if( is_zero(P) ) return( zdd0() )
  if( is_zero(Q) ) return(   P    )
  if(  is_one(P) ) return( zdd1() )
  if(  is_one(Q) ) return( zdd0() )
  # IDEALLY, THIS CAN BE SOLVED BY RECURSION FOR THE FOLLOWING CONDITIONS
  # if(   P == Q   ) return( ? )
  # if(   P <  Q   ) return( ? )
  # if(   P >  Q   ) return( ? )
  # return(  ?  )
  #
  # UNTIL WE GET SMARTER, THE BRUTE FORCE METHOD WILL HAVE TO DO:
  return( P - (P*Q) )
}

#' infix operator for zdd_anot
#'
#' @param a a zdd list object
#' @param b a zdd list object
#'
#' @return zdd_anot(a,b)
#'
#' @export
`%anot%` <- function(a,b) zdd_anot(a,b)


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
  if(   P == Q   ) return( zdd0()         )  #          =  P anot P = 0
  if( is_zero(P) ) return( zdd0()         )  # P anot Q =  0 anot Q = 0
  if( is_zero(Q) ) return(   P            )  #          =  P anot 0 = P
  if(  is_one(P) ) return( zdd1()         )  #          =  1 anot Q = 1
  if(  is_one(Q) ) return( zdd0()         )  #          =  P anot 1 = 0
  if(   P <  Q   ) return( P %anot% p0(Q) )  # P anot (Q0 + Qv*Q1) = P anot Q0
  if(   P >  Q   )
    return(
      zdd(value = P,
          p0    = p0(P) %anot% Q,
          p1    = p1(P) %anot% Q)
    )
  return(                              # (P0 + Pv*P1) anot (Q0 + Pv*Q1)
    #zdd(value = P,                     #   = (P0 anot Q0) + Pv*(P1 anot Q0|Q1)
    #    p0    = p0(P) %anot% p0(Q),
    #    p1    = p1(P) %anot% (p0(Q) | p1(Q) ) )
    P - (P*Q)
  )
}

#' infix operator for zdd_anot
#'
#' @param a a zdd list object
#' @param b a zdd list object
#'
#' @return zdd_anot(a,b)
#'
#' @export
`%anot%` <- function(a,b) zdd_binary_function(a, 'zdd_anot', b)


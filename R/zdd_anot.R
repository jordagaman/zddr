#' zdd_anot
#'
#' @param zddP a zdd list object
#' @param zddQ a zdd list object
#'
#' @return a zdd list object that is the elements of the first object that are nonminimal to the second
#' @export
#'
#' @examples
#' cutsets( (zdd(3) | zdd(4)) %% zdd(4))
#' cutsets( (zdd(3) * zdd(4)) %% zdd(4))
zdd_anot <- function(zddP, zddQ) {
  P <- as_zdd(zddP)
  Q <- as_zdd(zddQ)
  if( is_zero(P) ) return( zdd0()     )  # P %% Q            =  0 %% Q = 0
  if(  is_one(Q) ) return( zdd0()     )  #                   =  P %% 1 = 0
  if( is_zero(Q) ) return(   P        )  #                   =  P %% 0 = P
  if(  is_one(P) ) return( zdd1()     )  #                   =  1 %% Q = 1
  if(   P <  Q   ) return( P %% p0(Q) )  # P %% (Q0 + Qv*Q1) =  P %% Q0
  if(   P >  Q   )
    return(
      zdd(value = P,
          p0    = p0(P) %% Q,
          p1    = p1(P) %% Q)
    )
  return(                              # (P0 + Pv*P1) %% (Q0 + Pv*Q1)
    zdd(value = P,                     #   = (P0 %% Q0) + Pv*(P1 %% Q0|Q1)
        p0    = p0(P) %% p0(Q),
        p1    = p1(P) %% p0(Q) %% p1(Q))
  )
}

#' @export
'%%.zdd' <- function(a,b) zdd_binary_function(a, 'zdd_anot', b)


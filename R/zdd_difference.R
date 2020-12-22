#' zdd_difference
#'
#' @param zddP a zdd list object
#' @param zddQ a zdd list object
#'
#' @return a zdd list object that is the difference between the two zdds
#' @export
#'
#' @examples
#' (as_zdd(2L) | 3L) - 3L  # {2}
#' (as_zdd(2L) | 3L) - 2L  # {3}
zdd_difference <- function(zddP, zddQ) {
  P <- as_zdd(zddP)
  Q <- as_zdd(zddQ)
  if( is_zero(P) ) return(zdd0())      # P - Q =  0 - Q = 0
  if( is_zero(Q) ) return(  P   )      #       =  P - 0 = P
  if(   P == Q   ) return(zdd0())      #       =  P - P = 0
  #if(  is_one(P) ) return(zdd1())      # P - Q =  1 - Q = 1
  #if(  is_one(Q) ) return(zdd1())      #       =  P - 1 = 1
  if(   P <  Q   ) return(Q - P )
  if(   P >  Q   )                     # (P0 + Pv*P1) - Q
    return(                            #    = (P0 - Q) + Pv*P1
      zdd(value = P,
          p0    = p0(P) - Q,
          p1    = p1(P))
    )
  return(                              # (P0 + Pv*P1) - (Q0 + Pv*Q1)
    zdd(value = P,                     #   = (P0 - Q0) + Pv*(P1 - Q1)
        p0    = p0(P) - p0(Q),
        p1    = p1(P) - p1(Q))
  )
}

#' @export
'-.zdd' <- function(a,b) zdd_difference(a,b)

#Diff (P, Q) {
#  if (P == ø) return ø;
#  if (Q == ø) return P;
#  if (P == Q) return ø;
#  if (P.top > Q.top) return Getnode(P.top, Diff(P0, Q), P1;)
#  if (P.top < Q.top) return Diff(P, Q0);
#  if (P.top == Q.top)
#    return Getnode (P.top, Diff(P0, Q0), Diff(P1, Q1));
#}

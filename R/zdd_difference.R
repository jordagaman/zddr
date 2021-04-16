#' zdd_difference
#'
#' @param zddP a zdd list object
#' @param zddQ a zdd list object
#'
#' @return a zdd list object that is the difference between the two zdds
#' @export
#'
#' @examples
#' (zdd(2L) | 3L) - 3L  # {2}
#' (zdd(2L) | 3L) - 2L  # {3}
zdd_difference <- function(zddP, zddQ) {
  P <- as_zdd(zddP)
  Q <- as_zdd(zddQ)
  if(   P == Q   ) return(  as_zdd(F)) #       =  P - P = 0
  if( is_zero(P) ) return(  as_zdd(F)) # P - Q =  0 - Q = 0
  if( is_zero(Q) ) return(    P      ) #       =  P - 0 = P
  if(  is_one(P) ) return(  as_zdd(T)) #       =  1 - Q = 1
  if(  is_one(Q) ) return(  as_zdd(F)) #       =  P - 1 = 0
  if(   P <  Q   ) return( P - p0(Q) ) # P - (Q0 + Qv*Q1) = P - Q0
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
'-.zdd' <- function(a,b) zdd_binary_function(a, 'zdd_difference', b)

#Diff (P, Q) {
#  if (P == ø) return ø;
#  if (Q == ø) return P;
#  if (P == Q) return ø;
#  if (P.top > Q.top) return Getnode(P.top, Diff(P0, Q), P1;)
#  if (P.top < Q.top) return Diff(P, Q0);
#  if (P.top == Q.top)
#    return Getnode (P.top, Diff(P0, Q0), Diff(P1, Q1));
#}

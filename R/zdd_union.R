#' zdd_union
#'
#' @param zddP a zdd list object
#' @param zddQ a zdd list object
#'
#' @return a zdd list object that is the union of the two input zdds
#' @export
#'
#' @examples
#' zdd_union(zdd(2L), zdd(3L))
#' zdd(2L) | zdd(3L)
zdd_union <- function(zddP, zddQ) {
  P <- as_zdd(zddP)
  Q <- as_zdd(zddQ)
  if(   P == Q   ) return(  P   )      #       =  P | P = P
  if(  is_one(P) ) return(zdd1())      # P | Q =  1 | Q = 1
  if(  is_one(Q) ) return(zdd1())      #       =  P | 1 = 1
  if( is_zero(P) ) return(  Q   )      #       =  0 | Q = Q
  if( is_zero(Q) ) return(  P   )      #       =  P | 0 = P
  if(   P <  Q   ) return(Q | P )
  if(   P >  Q   )                     # (P0 + Pv*P1) | Q
    return(                            #    = (P0 | Q) + Pv*P1
      zdd(value = P,
          p0    = p0(P) | Q,
          p1    = p1(P))
    )
  return(                              # (P0 + Pv*P1) | (Q0 + Pv*Q1)
    zdd(value = P,                     #   = (P0 | Q0) + Pv*(P1 | Q1)
        p0    = p0(P) | p0(Q),
        p1    = p1(P) | p1(Q))
  )
}

#' @export
'|.zdd' <- function(a,b) zdd_binary_function(a, 'zdd_union', b)
#Union (P, Q) {
#  if (P == ø) return Q;
#  if (Q == ø) return P;
#  if (P == Q) return P;
#  if (P.top > Q.top) return Getnode (P.top, Union(P0, Q), P1);
#  if (P.top < Q.top) return Getnode (Q.top, Union(P, Q0), Q1);
#  if (P.top == Q.top)
#    return Getnode (P.top, Union(P0, Q0), Union(P1, Q1));
#}

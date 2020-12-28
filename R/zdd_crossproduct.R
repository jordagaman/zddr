#' zdd_crossproduct
#'
#' @param zddP a zdd list object
#' @param zddQ a zdd list object
#'
#' @return a zdd list object that is the crossproduct of the two input zdds
#' @export
#'
#' @examples
#' zdd_crossproduct(zdd(2L), zdd(3L))
#' zdd(2L) * zdd(3L)
#' (zdd(1L)|zdd(2L)|zdd(3L)) * (zdd(3L)|zdd(4L)|zdd(5L))
zdd_crossproduct <- function(zddP, zddQ) {
  P <- as_zdd(zddP)
  Q <- as_zdd(zddQ)
  if(  is_one(P) ) return(  Q   )      # P * Q =  1 * Q = Q
  if(  is_one(Q) ) return(  P   )      #       =  P * 1 = P
  if( is_zero(P) ) return(zdd0())      #       =  0 * Q = 0
  if( is_zero(Q) ) return(zdd0())      #       =  P * 0 = 0
  if(   P == Q   ) return(  P   )      #       =  P * P = P
  if(   P <  Q   ) return(Q * P )
  if(   P >  Q   )                     # (P0 + Pv*P1) * Q
    return(                            #    = (P0 * Q) + Pv*(P1 * Q)
      zdd(value = P,
          p0    = p0(P) * Q,
          p1    = p1(P) * Q)
    )
  return(                              # (P0 + Pv*P1) * (Q0 + Pv*Q1)
    zdd(value = P,                     #   = (P0 * Q0) + Pv*(P1*Q0 | P1*Q1 | P0*Q1)
        p0    = p0(P) * p0(Q),         #   = (P0 * Q0) + Pv*(P1*(Q0|Q1) | P0*Q1 )
        p1    = ( p1(P)* (p0(Q)|p1(Q)) ) | p0(P)*p1(Q) )
  )
}

#' @export
'*.zdd' <- function(a,b) zdd_binary_function(a, 'zdd_crossproduct', b)
#Union (P, Q) {
#  if (P == ø) return Q;
#  if (Q == ø) return P;
#  if (P == Q) return P;
#  if (P.top > Q.top) return Getnode (P.top, Union(P0, Q), P1);
#  if (P.top < Q.top) return Getnode (Q.top, Union(P, Q0), Q1);
#  if (P.top == Q.top)
#    return Getnode (P.top, Union(P0, Q0), Union(P1, Q1));
#}

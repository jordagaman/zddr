#' zdd_intersection
#'
#' @param zddP a zdd list object
#' @param zddQ a zdd list object
#'
#' @return a zdd list object that is the intersection of the two input zdds
#' @export
#'
#' @examples
#' zdd(2L) | zdd(3L) & zdd(3L)   # { {2}, {3} }
#' (zdd(2L) | zdd(3L)) & zdd(3L) # {   {3}    }
zdd_intersection <- function(zddP, zddQ) {
  P <- as_zdd(zddP)
  Q <- as_zdd(zddQ)
  if(   P == Q   ) return(      P        ) #       =  P & P = P
  if( is_zero(P) ) return(  as_zdd(F)    ) # P & Q =  0 & Q = 0
  if( is_zero(Q) ) return(  as_zdd(F)    ) #       =  P & 0 = 0
  if(  is_one(P) ) return(  as_zdd(F)    ) #       =  1 & Q = 0
  if(  is_one(Q) ) return(  as_zdd(F)    ) #       =  P & 1 = 0
  if(   P <  Q   ) return(    P  & p0(Q) ) #      P       & (Q0 + Qv*Q1) = P &Q0
  if(   P >  Q   ) return( p0(P) &    Q  ) # (P0 + Pv*P1) &     Q        = P0&Q
  return(
    zdd(value = P,                         # (P0 + Pv*P1) & (Q0 + Pv*Q1)
        p0    = p0(P) & p0(Q),             #   = (P0 & Q0) + Pv*(P1 & Q1)
        p1    = p1(P) & p1(Q))
  )
}

#' @export
'&.zdd' <- function(a,b) zdd_binary_function(a, 'zdd_intersection', b)

#Intsec (P, Q) {
#  if (P == ø) return ø;
#  if (Q == ø) return ø;
#  if (P == Q) return P;
#  if (P.top > Q.top) return Intsec(P0, Q);
#  if (P.top < Q.top) return Intsec (P, Q0);
#  if (P.top == Q.top)
#    return Getnode (P.top, Intsec(P0, Q0), Intsec(P1, Q1));
#}

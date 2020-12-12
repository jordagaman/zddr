#' zdd_union
#'
#' @param zddP a zdd list object
#' @param zddQ a zdd list object
#'
#' @return a zdd list object that is the union of the two input zdds
#' @export
#'
#' @examples zdd_union(as_zdd(2L), as_zdd(3L))
zdd_union <- function(zddP, zddQ) {
  if(is_zero(zddP)       ) return(zddQ)
  if(is_zero(zddQ)       ) return(zddP)
  if(is_equal(zddP, zddQ)) return(zddP)
  Pv <- zddP$value
  P0 <- get_zdd(zddP$p0)
  P1 <- get_zdd(zddP$p1)
  Qv <- zddQ$value
  Q0 <- get_zdd(zddQ$p0)
  Q1 <- get_zdd(zddQ$p1)
  if(Pv < Qv) return(zdd_union(zddQ, zddP))
  if(Pv > Qv)
    return(
      zdd(value = Pv,
          p0    = zdd_union(P0, zddQ)$hash,
          p1    = P1$hash)
    )
  if(Pv == Qv)
    return(
      zdd(value = zddP$value,
          p0    = zdd_union(P0, Q0)$hash,
          p1    = zdd_union(P1, Q1)$hash)
    )
}

#Union (P, Q) {
#  if (P == ø) return Q;
#  if (Q == ø) return P;
#  if (P == Q) return P;
#  if (P.top > Q.top) return Getnode (P.top, Union(P0, Q), P1);
#  if (P.top < Q.top) return Getnode (Q.top, Union(P, Q0), Q1);
#  if (P.top == Q.top)
#    return Getnode (P.top, Union(P0, Q0), Union(P1, Q1));
#}

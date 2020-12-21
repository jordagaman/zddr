#' zdd_union
#'
#' @param zddP a zdd list object
#' @param zddQ a zdd list object
#'
#' @return a zdd list object that is the union of the two input zdds
#' @export
#'
#' @examples
#' zdd_union(as_zdd(2L), as_zdd(3L))
#' as_zdd(2L) | as_zdd(3L)
zdd_union <- function(zddP, zddQ) {
  if(  is_one(zddP) ) return(zdd1())
  if(  is_one(zddQ) ) return(zdd1())
  if( is_zero(zddP) ) return(zddQ  )
  if( is_zero(zddQ) ) return(zddP  )
  if( zddP == zddQ  ) return(zddP  )
  if(zddP < zddQ) return(zddQ | zddP)
  if(zddP > zddQ)
    return(
      zdd(value = zddP,
          p0    = p0(zddP) | zddQ,
          p1    = p1(zddP))
    )
  return(
    zdd(value = zddP,
        p0    = p0(zddP) | p0(zddQ),
        p1    = p1(zddP) | p1(zddQ))
  )
}

#' @export
'|.zdd' <- function(a,b) zdd_union(a,b)
#Union (P, Q) {
#  if (P == ø) return Q;
#  if (Q == ø) return P;
#  if (P == Q) return P;
#  if (P.top > Q.top) return Getnode (P.top, Union(P0, Q), P1);
#  if (P.top < Q.top) return Getnode (Q.top, Union(P, Q0), Q1);
#  if (P.top == Q.top)
#    return Getnode (P.top, Union(P0, Q0), Union(P1, Q1));
#}

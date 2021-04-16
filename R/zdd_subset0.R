#' zdd_subset0
#'
#' @param zdd a zdd list object
#' @param value a value
#'
#' @return the subset of zdd such as value = TRUE
#' @export
#'
#' @examples
#' zdd_subset0(zdd(2L), 2L)# ONE
#' zdd_subset0(zdd(2L), 1L)# {2}
#' zdd_subset0(zdd(1L), 2L)# ZERO
#' zdd_subset0(zdd_and(3,4,5), 2L)   # {3,4,5}
#' zdd_subset0(zdd_and(3,4,5), 5L)   # {}
zdd_subset0 <- function(zdd, value) {
  if(is_zero(zdd)) return(as_zdd(F))
  if( is_one(zdd)) return(as_zdd(T))
  if(zdd < value ) return(zdd      )  # note that the standard algorithm for this says to return zero here
  if(zdd > value ) return(
    zdd(value = zdd,
        p0    = zdd_subset0(p0(zdd), value),
        p1    = zdd_subset0(p1(zdd), value))
  )
  return(p0(zdd))
}

#Subset0 (P, var) {
#  if (P.top < var) return ø;
#  if (P.top == var) return P0;
#  if (P.top > var)
#    return Getnode (P.top, Subset0(P0, var), Subset0(P1, var));
#}

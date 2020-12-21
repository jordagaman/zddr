#' zdd_subset1
#'
#' @param zdd a zdd list object
#' @param value a value
#'
#' @return the subset of zdd such as value = TRUE
#' @export
#'
#' @examples
#' zdd_subset1(as_zdd(2L), 2L)# ONE
#' zdd_subset1(as_zdd(2L), 1L)# {2}
#' zdd_subset1(as_zdd(1L), 2L)# ZERO
#' library(magrittr)
#' zdd345 <-
#'   zdd(3L, zdd0(), zdd1()) %>%
#'   zdd(4L, zdd0(), .     ) %>%
#'   zdd(5L, zdd0(), .     )
#' zdd_subset1(zdd345, 4L)   # {3,5}
zdd_subset1 <- function(zdd, value) {
  if(is_zero(zdd)) return(zdd0())
  if( is_one(zdd)) return(zdd0())
  if(zdd < value ) return(zdd0())
  if(zdd > value ) return(
    zdd(value = zdd,
        p0    = zdd_subset1(p0(zdd), value),
        p1    = zdd_subset1(p1(zdd), value))
  )
  return(p1(zdd))
}

#Subset1 (P, var) {
#  if (P.top < var) return ø;
#  if (P.top == var) return P1;
#  if (P.top > var)
#    return Getnode (P.top, Subset1(P0, var), Subset1(P1, var));
#}

#' zdd_or
#'
#' @param ... a list of objects that can be coerced to zdds
#'
#' @return a zdd that is the union of all inputs
#' @export
#'
#' @examples
#' zdd_or(1,2,3,4)
#' zdd_or( zdd_and(1,2), zdd_and(3,4) ) # { {1,2}, {3,4} }
#' zdd_or( zdd_and(1,2,3,4,5), 4)       # { {4} }
zdd_or <- function(...) {
  input_list <- list(...)
  input_list <- purrr::map_chr(input_list, as_zdd)
  if(any(purrr::map_lgl(input_list, is_one)))
    return(zdd1())
  return(
    purrr::reduce(input_list, zdd_union)
  )
}

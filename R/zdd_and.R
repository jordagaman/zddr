#' zdd_and
#'
#' @param ... a list of objects that can be coerced to zdds
#'
#' @return a zdd that is the crossmultiplication of all inputs
#' @export
#'
#' @examples
#' zdd_and(1,2,3,4)
zdd_and <- function(...) {
  input_list <- list(...)
  return(lzdd_and(input_list))
}

lzdd_and <- function(lst) {
  input_list <- purrr::map_chr(lst, as_zdd)
  if(any(purrr::map_lgl(input_list, is_zero)))
    return(as_zdd(F))
  return(
    purrr::reduce(input_list, zdd_crossproduct)  # this would probably be faster if the list was sorted first
  )
}

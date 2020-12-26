#' cutsets
#'
#' @param zdd a zdd list object
#'
#' @return a list of integer vectors representing a family of sets (cutsets)
#' @export
#'
#' @examples
#' library(magrittr)
#' zdd3 <- zdd(3L)
#' zdd4 <- zdd(4L)
#' zdd3 %>% zdd_union(zdd4) %>% cutsets()
#' zdd4 %>% zdd_union(zdd3) %>% cutsets()
#' zdd4 %>% zdd_union(zdd0()) %>% cutsets()
#' zdd4 %>% zdd_union(zdd1()) %>% cutsets()
cutsets <- function(zdd) {
  if( is_one(zdd)) return(list( c() ))
  if(is_zero(zdd)) return(list(     ))
  add_to_every_vector <- function(list_of_vectors, value) {
    purrr::map(
      list_of_vectors,
      ~ c(.x, value)
    )
  }
  p0_cutsets <- cutsets(p0(zdd))
  p1_cutsets <- cutsets(p1(zdd))
  return(
    append(
      p0_cutsets,
      add_to_every_vector(p1_cutsets, as.integer(zdd))
    )
  )
}

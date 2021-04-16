#' cutsets
#'
#' @param zdd a zdd list object
#'
#' @return a list of integer vectors representing a family of sets (cutsets)
#' @export
#'
#' @examples
#' cutsets( zdd(3) | zdd(4) )
#' cutsets( zdd(4) | zdd(3) )
#' cutsets( zdd(4) | FALSE  )
#' cutsets( zdd(4) | TRUE   )
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

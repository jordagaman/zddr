#' cutsets
#'
#' @param zdd a zdd list object
#'
#' @return a list of integer vectors representing a family of sets (cutsets)
#' @export
#'
#' @examples
#' cutsets( zdd_union(as_zdd(3L), as_zdd(4L) ) )
#' cutsets( zdd_union(as_zdd(4L), as_zdd(3L) ) )
#' cutsets( zdd_union(as_zdd(4L), zdd0()     ) )
#' cutsets( zdd_union(as_zdd(4L), zdd1()     ) )
cutsets <- function(zdd) {
  if( is_one(zdd)) return(list( c() ))
  if(is_zero(zdd)) return(list(     ))
  add_to_every_vector <- function(list_of_vectors, value) {
    purrr::map(
      list_of_vectors,
      function(x) c(x, value)
    )
  }
  p0_cutsets <- cutsets(as_zdd(zdd$p0))
  p1_cutsets <- cutsets(as_zdd(zdd$p1))
  return(
    append(
      p0_cutsets,
      add_to_every_vector(p1_cutsets, zdd$value)
    )
  )
}

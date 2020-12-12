#' reset_zdd_store
#'
#' @param quiet when FALSE, print a message whenever this command is run
#'
#' @return NULL
#' @export
#'
#' @examples reset_zdd_store(quiet = TRUE)
reset_zdd_store <- function(quiet = FALSE) {
  if(!quiet)
    message("Resetting zdd_store.")
  remove(
    list = ls(envir = zddr::zdd_store),
    envir = zddr::zdd_store
  )
  return(NULL)
}

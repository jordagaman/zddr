#' reset_zdd_store
#'
#' @param keep_protected when TRUE, preserves the ZDD nodes that are marked protected
#' @param quiet when FALSE, print a message whenever this command is run
#'
#' @return NULL
#' @export
#'
#' @examples
#' reset_zdd_store(quiet = TRUE)
reset_zdd_store <- function(keep_protected = TRUE, quiet = FALSE) {
  if(!quiet)
    message("Resetting zdd_store.")
  if(keep_protected) {
    l <- lapply(
      ls(envir = zddr::zdd_store),
      function(x)
        if(!zdd_protected(x))
          remove(list = x, envir = zddr::zdd_store)
    )
  } else {
    remove(
      list = ls(envir = zddr::zdd_store),
      envir = zddr::zdd_store
    )
  }
  remove(
    list = ls(envir = zddr::zdd_fxns),
    envir = zddr::zdd_fxns
  )
}

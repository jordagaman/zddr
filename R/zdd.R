#' zdd
#'
#' @param value the integer value of the node
#' @param p0 the negative compliment of the zdd with respect to `value`, expressed as a string hash or as class zdd
#' @param p1 the positive compliment of the zdd with respect to `value`, expressed as a string hash or as class zdd
#'
#' @return the resulting zdd node, expressed as class zdd
#' @export
#'
#' @examples
#' zdd(1L, zdd0(), zdd1())
zdd <- function(value, p0, p1) {
  if( is_one(p0)) return(zdd1())  # p0 + v*p1 = 1  + v*p1 = 1
  if(is_zero(p1)) return(  p0  )  #           = p0 + v*0  = p0
  if( p0 == p1  ) return(  p1  )  #           = p1 + v*p1 = p1
  z <- new_zdd(value, p0, p1)
  if(!zdd_exists(z)) register_zdd(z)
  return(z)
}

#' new_zdd
#'
#' @param value the integer value of the node
#' @param p0 the negative compliment of the zdd with respect to `value`, expressed as a string hash or as class zdd
#' @param p1 the positive compliment of the zdd with respect to `value`, expressed as a string hash or as class zdd
#'
#' @return the resulting zdd node, expressed as class zdd
new_zdd <- function(value, p0, p1) {
  V  <- as.integer(value)
  P0 <- as.character(p0)
  P1 <- as.character(p1)
  count <- zdd_count(p0) + zdd_count(p1)

  return(
    structure(.Data = list(value = V,
                           p0    = P0,
                           p1    = P1,
                           hash  = zdd_hash(V, P0, P1) ),
              class = 'zdd',
              count = count)
  )
}

zdd_exists <- function(zdd) {
  z <- as.character(zdd)
  return(exists(z, envir = zddr::zdd_store))
}

register_zdd <- function(zdd) {
  assign(
    x     = as.character(zdd),
    value = zdd,
    envir = zddr::zdd_store
  )
}

#' zdd hash
#'
#' @param value the integer value of the node
#' @param p0 the negative compliment of the zdd with respect to `value`, expressed as class zdd
#' @param p1 the positive compliment of the zdd with respect to `value`, expressed as class zdd
#'
#' @return hash
#'
#' @examples
#' zddr:::zdd_hash(1L, zdd0()$hash, zdd1()$hash)
zdd_hash <- function(value, p0, p1) {
  if(!is.integer(value))
    stop('value must be an integer')
  if(value < 0)
    stop('value must not be negative')
  if(!zdd_exists(p0))
    stop('p0 must be a registered zdd node')
  if(!zdd_exists(p1))
    stop('p1 must be a registered zdd node')
  digest::digest(
    object = list(value, p0, p1),
    raw    = FALSE
  )
}

#' print zdd
#'
#' @param x a zdd
#' @param ... all the other stuff
#'
#' @return printed zdd
#' @export
#'
#' @examples
#' print(zdd0())
#' print(as_zdd(3L))
print.zdd <- function(x, ...) {
  cat(crayon::blue(as.character(x)), ':', sep = '')
  if( is_one(x)) {
    cat(crayon::green('ONE'))
  } else if(is_zero(x)) {
    cat(crayon::red('ZERO'))
  } else {
    cat(crayon::cyan(as.integer(x)),
        as.character(p0(x)),
        as.character(p1(x)),
        sep = ',')
  }
  cat('\n')
}

#' zdd as integer
#'
#' @param x a zdd
#' @param ... all the other stuff
#'
#' @return the integer value of the zdd node
#' @export
#'
#' @examples
#' as.integer( as_zdd(3L) )
as.integer.zdd <- function(x, ...) {
  if( is_one(x)) stop('You just asked me to return the value for a constant-1 node!')
  if(is_zero(x)) stop('You just asked me to return the value for a constant-0 node!')
  return(x$value)
}

#' zdd as character
#'
#' @param x a zdd
#' @param ... all the other stuff
#'
#' @return the string ID of the zdd node
#' @export
#'
#' @examples
#' as.character( as_zdd(3L) )
as.character.zdd <- function(x, ...) {
  return(x$hash)
}

p0 <- function(x) {
  zdd <- as_zdd(x)
  if( is_one(zdd)) stop('You just asked me to return the p0 value for a constant-1 node!')
  if(is_zero(zdd)) stop('You just asked me to return the p0 value for a constant-0 node!')
  return(as_zdd(zdd$p0))
}
p1 <- function(x) {
  zdd <- as_zdd(x)
  if( is_one(zdd)) stop('You just asked me to return the p1 value for a constant-1 node!')
  if(is_zero(zdd)) stop('You just asked me to return the p1 value for a constant-0 node!')
  return(as_zdd(zdd$p1))
}

#' @export
zdd_count <- function(x) {
  zdd <- as_zdd(x)
  return(attr(zdd, 'count'))
}

#' @export
'==.zdd' <- function(a,b) as.character(a) == as.character(as_zdd(b))

#' @export
'<.zdd'  <- function(a,b) as.integer(a)   <  as.integer(as_zdd(b))

#' @export
'>.zdd'  <- function(a,b) as.integer(a)   >  as.integer(as_zdd(b))

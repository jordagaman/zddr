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
#' zdd(1L)
zdd <- function(value, p0 = FALSE, p1 = TRUE) {
  p0 = as_zdd(p0)
  p1 = as_zdd(p1)
  if( is_one(p0)) return(as_zdd(T)) # p0 + v*p1 = 1  + v*p1 = 1
  p1m <- if(getOption('MINIMIZE_EVERY_ZDD')) {
    p1 %%p0
  } else{
    p1
  }
  if(is_zero(p1m)) return(  p0   )  #           = p0 + v*0  = p0
  if( p0 == p1m  ) return(  p1m  )  #           = p1 + v*p1 = p1
  z <- new_zdd(value, p0, p1m)
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
  stopifnot(length(value)==1)
  V  <- as.integer(value)
  P0 <- as.character(p0)
  P1 <- as.character(p1)
  ID <- zdd_hash(V, P0, P1)
  p0_order <-       zdd_order(p0)
  p1_order <- c(0L, zdd_order(p1))
  highest_order <- max( length(p0_order), length(p1_order) )
  p0_order <- c(p0_order, rep(0, highest_order - length(p0_order)))
  p1_order <- c(p1_order, rep(0, highest_order - length(p1_order)))
  z  <- structure(
    .Data         = ID,
    value         = V,
    p0            = P0,
    p1            = P1,
    order         = p0_order + p1_order,
    minimum_order = min(zdd_minimum_order(p0), zdd_minimum_order(p1)+1L),
    maximum_order = max(zdd_maximum_order(p0), zdd_maximum_order(p1)+1L),
    protected     = FALSE,
    count         = zdd_count(p0) + zdd_count(p1),
    class         = 'zdd'
  )
  return(z)
}

zdd_exists <- function(zdd) {
  return(
    exists(zdd, envir = zddr::zdd_store)
  )
}

register_zdd <- function(zdd) {
  zdd_store[[zdd]] <- zdd
  return()
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
#' zddr:::zdd_hash(1L, as_zdd(FALSE), as_zdd(TRUE))
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
#' print(as_zdd(FALSE))
#' print(zdd(3L))
print.zdd <- function(x, ...) {
  zdd_mem <- round(pryr::object_size(zddr::zdd_store)/1e6,digits = 3)
  fxn_mem <- round(pryr::object_size(zddr::zdd_fxns )/1e6,digits = 3)
  zdd_cnt <- length(ls(zddr::zdd_store))
  fxn_cnt <- length(ls(zddr::zdd_fxns ))
  zdd_rat <- round(1e3*zdd_mem / zdd_cnt, digits = 2)
  fxn_rat <- round(1e3*fxn_mem / fxn_cnt, digits = 2)
  cat('Memory of ZDD Store:    ', zdd_mem, 'MB, item count:', zdd_cnt, '(', zdd_rat, 'KB/item)\n')
  cat('Memory of ZDD Functions:', fxn_mem, 'MB, item count:', fxn_cnt, '(', fxn_rat, 'KB/item)\n')
  cat(crayon::blue(as.character(x)), ':', zdd_count(x), 'cutsets, min order:', zdd_minimum_order(x), 'max order:', zdd_maximum_order(x), '\n')
  if( is_one(x)) {
    cat(crayon::green('ONE'))
  } else if(is_zero(x)) {
    cat(crayon::red('ZERO'))
  } else {
    cutset_orders <-zdd_order(x)
    attr(cutset_orders, 'names') <- paste0(1L:length(cutset_orders) - 1L, '-order')
    print(cutset_orders[cutset_orders>0L])
    if(zdd_count(x) > 100L) {
      cat(crayon::yellow('\nMore than 100 cutsets, not printing all those!\n'))
    } else {
      cutsets <- lapply(cutsets(x), paste, collapse = ',')
      cutsets <- paste0('{', cutsets, '}', collapse = ', ')
      cutsets <- strwrap(cutsets, width = 80)
      cutsets <- gsub('([{}],?)' , crayon::cyan('\\1' ), cutsets)
      cat( cutsets, sep = '\n')
    }
  }
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
#' as.integer( zdd(3L) )
as.integer.zdd <- function(x, ...) {
  if( is_one(x)) stop('You just asked me to return the value for a constant-1 node!')
  if(is_zero(x)) stop('You just asked me to return the value for a constant-0 node!')
  return(attr(x, 'value'))
}


p0 <- function(x) {
  UseMethod("p0")
}

p0.zdd <- function(x) {
  if( is_one(x)) stop('You just asked me to return the p0 value for a constant-1 node!')
  if(is_zero(x)) stop('You just asked me to return the p0 value for a constant-0 node!')
  p0  <- attr(x, 'p0')
  return(as_zdd(p0))
}

p0.logical <- function(x) {
  return(p0(as_zdd(x)))
}

p1 <- function(x) {
  UseMethod("p1")
}

p1.zdd <- function(x) {
  if( is_one(x)) stop('You just asked me to return the p1 value for a constant-1 node!')
  if(is_zero(x)) stop('You just asked me to return the p1 value for a constant-0 node!')
  p1  <- attr(x, 'p1')
  return(as_zdd(p1))
}

p1.logical <- function(x) {
  return(p1(as_zdd(x)))
}



zdd_order <- function(x) {
  zdd <- as_zdd(x)
  return(attr(zdd, 'order'))
}

zdd_minimum_order <- function(x) {
  zdd <- as_zdd(x)
  return(attr(zdd, 'minimum_order'))
}
zdd_maximum_order <- function(x) {
  zdd <- as_zdd(x)
  return(attr(zdd, 'maximum_order'))
}

zdd_count <- function(x) {
  zdd <- as_zdd(x)
  return(attr(zdd, 'count'))
}

zdd_protected <- function(x) {
  zdd <- as_zdd(x)
  return(attr(zdd, 'protected'))
}

#' @export
'==.zdd' <- function(a,b) as.character(a) == as.character(as_zdd(b))

#' @export
'<.zdd'  <- function(a,b) as.integer(a)   <  as.integer(as_zdd(b))

#' @export
'>.zdd'  <- function(a,b) as.integer(a)   >  as.integer(as_zdd(b))

#' helper function to store the results of binary operations
#'
#' @param P first zdd argument
#' @param op binary function
#' @param Q second zdd argument
zdd_binary_function <- function(P, op, Q) {
  fun <- match.fun(op)
  hash_calc <- digest::digest(list(P, fun, Q))
  result_exists <- exists(hash_calc, envir = zddr::zdd_fxns)
  if(result_exists) return(as_zdd(zdd_fxns[[hash_calc]]))
  res <- do.call(fun, list(P, Q))
  zdd_fxns[[hash_calc]] <- as.character(res)
  return( res )
}

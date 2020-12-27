## code to prepare `zdd_store` dataset goes here
# when package loads, we want to have a reliable environment where we can store
# zdd nodes
zdd_store <- new.env()
zdd_fxns  <- new.env()
usethis::use_data(zdd_store, zdd_fxns, overwrite = TRUE)

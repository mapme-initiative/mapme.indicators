#' Species richness - Mammals
#'
#' Species richness counts the number of species intersecting with a polygon
#' grouped by the IUCN threat categorization.
#'
#' The required resources for this indicator are:
#'  - [iucn_mammals]
#'
#' @name sr_mammals
#' @docType data
#' @keywords indicator
#' @format A tibble with columns for the code and full-text category as well
#'   as the count of the number of respective species.
NULL

#' @noRd
#' @include zzz.R
.calc_sr_mammals <- function(
    x,
    iucn_mammals,
    verbose = TRUE,
    ...) {

  iucn_mammals <- iucn_mammals[[1]]
  if(is.null(iucn_mammals)) return(NA)
  .calc_sr(table(iucn_mammals[["category"]]), "sr_mammals")
}

.register(list(
  name = "sr_mammals",
  resources = list(iucn_mammals = "vector"),
  fun = .calc_sr_mammals,
  arguments = list(),
  processing_mode = "asset"),
  "indicator")

#' Species richness - Reptiles
#'
#' Species richness counts the number of species intersecting with a polygon
#' grouped by the IUCN threat categorization.
#'
#' The required resources for this indicator are:
#'  - [iucn_reptiles]
#'
#' @name sr_reptiles
#' @docType data
#' @keywords indicator
#' @format A tibble with columns for the code and full-text category as well
#'   as the count of the number of respective species.
NULL

#' @noRd
#' @include zzz.R
.calc_sr_reptiles <- function(
    x,
    iucn_reptiles,
    verbose = TRUE,
    ...) {

  iucn_reptiles <- iucn_reptiles[[1]]
  if(is.null(iucn_reptiles)) return(NA)
  .calc_sr(table(iucn_reptiles[["category"]]), "sr_reptiles")
}

.register(list(
  name = "sr_reptiles",
  resources = list(iucn_reptiles = "vector"),
  fun = .calc_sr_reptiles,
  arguments = list(),
  processing_mode = "asset"),
  "indicator")

#' Species richness - Amphibians
#'
#' Species richness counts the number of species intersecting with a polygon
#' grouped by the IUCN threat categorization.
#'
#' The required resources for this indicator are:
#'  - [iucn_amphibians]
#'
#' @name sr_amphibians
#' @docType data
#' @keywords indicator
#' @format A tibble with columns for the code and full-text category as well
#'   as the count of the number of respective species.
NULL

#' @noRd
#' @include zzz.R
.calc_sr_amphibians <- function(
    x,
    iucn_amphibians,
    verbose = TRUE,
    ...) {


  iucn_amphibians <- iucn_amphibians[[1]]
  if(is.null(iucn_amphibians)) return(NA)
  .calc_sr(table(iucn_amphibians[["category"]]), "sr_mammals")
}

.register(list(
  name = "sr_amphibians",
  resources = list(iucn_amphibians = "vector"),
  fun = .calc_sr_amphibians,
  arguments = list(),
  processing_mode = "asset"),
  "indicator")

#' Species richness - Birds
#'
#' Species richness counts the number of species intersecting with a polygon.
#'
#' The required resources for this indicator are:
#'  - [birdlife]
#'
#' @name sr_birds
#' @docType data
#' @keywords indicator
#' @format A tibble with a column for the number of bird species which ranges
#'   intersect with a given polygon.
NULL

#' @noRd
#' @include zzz.R
.calc_sr_birds <- function(
    x,
    birdlife,
    verbose = TRUE,
    ...) {


  birdlife <- birdlife[[1]]
  if(is.null(birdlife)) return(NA)
  tibble::tibble(
    variable = "sr_birds",
    count = nrow(birdlife)
  )
}

.register(list(
  name = "sr_birds",
  resources = list(birdlife = "vector"),
  fun = .calc_sr_birds,
  arguments = list(),
  processing_mode = "asset"),
  "indicator")


.calc_sr <- function(cats, var = NULL) {
  out <- tibble::tibble(
    code = c("EX", "EW", "CR", "EN", "VU", "NT", "LC", "DD", "NE"),
    category = c("Extinct",
                 "Extinct in the wild",
                 "Critically endangered",
                 "Endangered",
                 "Vulnerable",
                 "Near threatened",
                 "Least concern",
                 "Data deficient",
                 "Not evaluated"),
    count = rep(0, 9)
  )

  index <- match(names(cats), out[["code"]])
  out[["count"]][index] <- cats
  out["variable"] <- var
  out[ ,c("variable", "code", "category", "count")]
}

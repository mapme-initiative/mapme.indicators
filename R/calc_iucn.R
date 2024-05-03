#' Species richness
#'
#' Species richness counts the number of potential species intersecting with a
#' polygon grouped by the IUCN threat categorization. For each animal group,
#' there is an indicator function which requires the availablity of the
#' respctive resource.
#'
#' The required resources for this indicator are:
#'  - see the respective [species_ranges]
#'
#' @name sr_mammals
#' @keywords indicator
#' @returns A function that returns a tibble with columns for the code and the
#'   full-text threat category as well as the count of the number of respective species.
#' @export
calc_sr_mammals <- function() {
  function(
    x,
    iucn_mammals,
    name = "sr_mammals",
    mode = "asset",
    verbose = mapme_options()[["verbose"]]) {

    iucn_mammals <- iucn_mammals[[1]]
    if(is.null(iucn_mammals)) return(NA)
    .calc_sr(table(iucn_mammals[["category"]]), "sr_mammals")
  }
}

register_indicator(
  name = "sr_mammals",
  description = "Species richness count for mammals by threat category.",
  resources = "iucn_mammals"
)

#' @name sr_reptiles
#' @keywords indicator
#' @inherit sr_mammals title description details return
#' @export
calc_sr_reptiles <- function() {
  function(
    x,
    iucn_reptiles,
    name = "sr_reptiles",
    mode = "asset",
    verbose = mapme_options()[["verbose"]]) {

    iucn_reptiles <- iucn_reptiles[[1]]
    if(is.null(iucn_reptiles)) return(NA)
    .calc_sr(table(iucn_reptiles[["category"]]), "sr_reptiles")
  }
}

register_indicator(
  name = "sr_reptiles",
  description = "Species richness count for reptiles by threat category.",
  resources = "iucn_reptiles"
)

#' @name sr_amphibians
#' @keywords indicator
#' @inherit sr_mammals title description details return
#' @export
calc_sr_amphibians <- function(){
  function(
    x,
    iucn_amphibians,
    name = "sr_amphibians",
    mode = "asset",
    verbose = mapme_options()[["verbose"]]) {

    iucn_amphibians <- iucn_amphibians[[1]]
    if(is.null(iucn_amphibians)) return(NA)
    .calc_sr(table(iucn_amphibians[["category"]]), "sr_amphibians")
  }
}

register_indicator(
  name = "sr_amphibians",
  description = "Species richness count for amphibians by threat category.",
  resources = "iucn_amphibians"
)


#' @name sr_birds
#' @keywords indicator
#' @inherit sr_mammals title description details return
#' @export
calc_sr_birds <- function() {
  function(
    x,
    birdlife,
    name = "sr_birds",
    mode = "asset",
    verbose = mapme_options()[["verbose"]]) {

    birdlife <- birdlife[[1]]
    if(is.null(birdlife)) return(NA)
    col_index <- grep("IUCN_Red_List_Category", names(birdlife))
    names(birdlife)[col_index] <- "category"
    .calc_sr(table(birdlife[["category"]]), "sr_birds")
  }
}

register_indicator(
  name = "sr_birds",
  description = "Species richness count for birds by threat category.",
  resources = "birdlife"
)


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

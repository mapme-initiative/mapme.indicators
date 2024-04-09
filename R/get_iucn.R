#' IUCN Red List of Threatened Species - Mammals
#'
#' This resource is part of the spatial data set Red List of Threatened Species
#' released by IUCN. The data are made available including taxonomic information,
#' distribution status, IUCN Red List Category, sources and other details. This
#' resource is free to use under a non-commercial licence. For commercial uses,
#' a request has to be sent to Integrated Biodiversity Assessment Tool (IBAT).
#'
#' To use this data in mapme workflows, you will have to manually download the
#' global data set and point towards the file path on your local machine.
#'
#' Note, that we are simplifying the species ranges polygons for better computational
#' efficiency.
#'
#' @name species_ranges
#' @param path A character vector to the respective species range file that
#'   has to be downloaded manually.
#' @keywords resource
#' @returns A function that returns a character vector of file paths.
#' @references IUCN (2024). The IUCN Red List of Threatened Species. https://www.iucnredlist.org.
#' \doi{https://doi.org/10.1038/s41597-022-01284-8 }
#' @source \url{https://www.iucnredlist.org/resources/spatial-data-download}
#' @export
get_iucn_mammals <- function(path = NULL) {

  if(is.null(path) || !file.exists(path) || basename(path) != "MAMMALS.zip") {
    stop("Expecting path to point towards a file called: 'MAMMALS.zip'.")
  }

  function(
    x,
    name = "iucn_mammals",
    type = "vector",
    outdir = mapme_options()[["outdir"]],
    verbose = mapme_options()[["verbose"]],
    testing = mapme_options()[["testing"]]) {

    dst <- file.path(outdir, gsub("zip", "fgb", basename(path)))
    src <- paste0("/vsizip/", path)
    if(!file.exists(dst)) .prep_iucn(src, dst, verbose = verbose)
    dst
  }
}

register_resource(
  name = "iucn_mammals",
  description = "Potential species ranges for mammals.",
  licence = "https://www.iucnredlist.org/terms/terms-of-use",
  source = "https://www.iucnredlist.org/resources/spatial-data-download",
  type = "vector"
)


#' @name species_ranges
#' @export
get_iucn_reptiles <- function(path = NULL) {

  if(is.null(path) || !file.exists(path) || basename(path) != "REPTILES.zip") {
    stop("Expecting path to point towards a file called: 'REPTILES.zip'.")
  }

  function(
    x,
    name = "iucn_reptiles",
    type = "vector",
    outdir = mapme_options()[["outdir"]],
    verbose = mapme_options()[["verbose"]],
    testing = mapme_options()[["testing"]]) {

    dst <-  file.path(outdir, gsub("zip", "gpkg", basename(path)))
    src <- paste0("/vsizip/", path)
    layers <- st_layers(src)[["name"]]
    if(length(layers) != 2) {
      stop("Expected REPTILES.zip to have two layers.")
    }
    if(!file.exists(dst)) .prep_iucn(src, dst, layers, verbose = verbose)
    dst
  }
}


register_resource(
  name = "iucn_reptiles",
  description = "Potential species ranges for reptiles.",
  licence = "https://www.iucnredlist.org/terms/terms-of-use",
  source = "https://www.iucnredlist.org/resources/spatial-data-download",
  type = "vector"
)

#' @name species_ranges
#' @export
get_iucn_amphibians <- function(path = NULL) {

  if(is.null(path) || !file.exists(path) || basename(path) != "AMPHIBIANS.zip") {
    stop("Expecting path to point towards a file called: 'AMPHIBIANS.zip'.")
  }

  function(
    x,
    name = "iucn_amphibians",
    type = "vector",
    outdir = mapme_options()[["outdir"]],
    verbose = mapme_options()[["verbose"]],
    testing = mapme_options()[["testing"]]) {

    dst <- file.path(outdir, gsub("zip", "fgb", basename(path)))
    src <- paste0("/vsizip/", path)
    layers <- st_layers(src)[["name"]]
    if(length(layers) != 2) {
      stop("Expected AMPHIBIANS.zip to have two layers.")
    }
    if(!file.exists(dst)) .prep_iucn(src, dst, verbose = verbose)
    dst
  }
}


register_resource(
  name = "iucn_amphibians",
  description = "Potential species ranges for amphibians.",
  licence = "https://www.iucnredlist.org/terms/terms-of-use",
  source = "https://www.iucnredlist.org/resources/spatial-data-download",
  type = "vector"
)

#' The birdlife resource is part of the spatial data set of bird ranges
#' released by BirdLife International. This resource is free to use under a
#' non-commercial licence. For commercial uses, a request has to be sent to
#' BirdLife International.
#'
#' @name species_ranges
#' @references BirdLife International and Handbook of the Birds of the World (2022).
#'   Bird species distribution maps of the world. Version 2022.2. Available at
#'   http://datazone.birdlife.org/species/requestdis
#' @export
get_birdlife <- function(path = NULL) {

  if(is.null(path) || !file.exists(path) || basename(path) != "BOTW.gdb") {
    stop("Expecting path to point towards a file called: 'BOTW.gdb'.")
  }

  function(
    x,
    name = "birdlife",
    type = "vector",
    outdir = mapme_options()[["outdir"]],
    verbose = mapme_options()[["verbose"]],
    testing = mapme_options()[["testing"]]) {

    layers <- st_layers(path)
    polys_layer <- grep("Species", layers$name, value = TRUE)
    meta_layer <- grep("Species", layers$name, value = TRUE, invert = TRUE)
    if (length(polys_layer) != 1 || length(meta_layer) != 1) {
      stop("Expected 'birdlife' to have exactly two layers. Please raise an issue.")
    }
    sql <- sprintf("select * from %s inner join %s on %s.sisid=%s.sisid;",
                   polys_layer, meta_layer, polys_layer, meta_layer)
    dst <- file.path(outdir, gsub("gdb", "fgb", basename(path)))
    if(!file.exists(dst)) .prep_iucn(path, dst, sql, verbose)
    dst
  }
}

register_resource(
  name = "birdlife",
  description = "Potential species ranges for birds.",
  licence = "https://datazone.birdlife.org/info/dataterms",
  source = "http://datazone.birdlife.org/species/requestdis",
  type = "vector"
)


.prep_iucn <- function(src, dst, layers = NULL, sql = NULL, verbose = TRUE) {

  if(verbose) opts <- "-progress"
  if(!is.null(sql)) opts <- c(opts, "-dialect", "sqlite", "-sql", sql)
  if(is.null(layers)) layers <- st_layers(src)[["name"]]
  nln <- basename(dst)
  opts <- c(
    opts,
    "-append",
    "-makevalid",
    "-skipfailures",
    "-simplify", "0.01",
    "-nln", nln,
    "-nlt", "PROMOTE_TO_MULTI")

  for (layer in layers) {

    opt_tmp <- c(opts, layer)

    sf::gdal_utils(
      "vectortranslate",
      source = src,
      destination = dst,
      quiet = FALSE,
      options = opt_tmp)

  }
}

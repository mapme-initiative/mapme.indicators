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
#' @name iucn_mammals
#' @docType data
#' @keywords resource
#' @format A global vector data set indicating species ranges
#' @references IUCN (2024). The IUCN Red List of Threatened Species. https://www.iucnredlist.org.
#' https://doi.org/10.1038/s41597-022-01284-8
#' @source \url{https://www.iucnredlist.org/resources/spatial-data-download}
NULL


#' @noRd
#' @include zzz.R
.get_iucn_mammals <- function(
    x,
    path = NULL,
    rundir = tempdir(),
    verbose = TRUE) {

  if(is.null(path)){
    stop("'path' cannot be NULL.")
  }

  if(basename(path) != "MAMMALS.zip"){
    stop("Expecting path to point towards a file called: 'MAMMALS.zip'.")
  }

  dst <- file.path(rundir, gsub("zip", "fgb", basename(path)))
  src <- paste0("/vsizip/", path)
  if(!file.exists(dst)) .prep_iucn(src, dst, verbose = verbose)
  dst
}


.register(list(
  name = "iucn_mammals",
  type = "vector",
  source = "https://www.iucnredlist.org/resources/spatial-data-download",
  fun = .get_iucn_mammals,
  arguments = list(
    path = NULL
  )),
  "resource")

#' IUCN Red List of Threatened Species - Reptiles
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
#' @name iucn_reptiles
#' @docType data
#' @keywords resource
#' @format A global vector data set indicating species ranges
#' @references IUCN (2024). The IUCN Red List of Threatened Species. https://www.iucnredlist.org.
#' https://doi.org/10.1038/s41597-022-01284-8
#' @source \url{https://www.iucnredlist.org/resources/spatial-data-download}
NULL


#' @noRd
#' @include zzz.R
.get_iucn_reptiles <- function(
    x,
    path = NULL,
    rundir = tempdir(),
    verbose = TRUE) {

  if(is.null(path)){
    stop("'path' cannot be NULL.")
  }

  if(basename(path) != "REPTILES.zip"){
    stop("Expecting path to point towards a file called: 'REPTILES.zip'.")
  }

  dst <-  file.path(rundir, gsub("zip", "fgb", basename(path)))
  src <- paste0("/vsizip/", path)
  if(!file.exists(dst)) .prep_iucn(src, dst, verbose = verbose)
  dst
}


.register(list(
  name = "iucn_reptiles",
  type = "vector",
  source = "https://www.iucnredlist.org/resources/spatial-data-download",
  fun = .get_iucn_reptiles,
  arguments = list(
    path = NULL
  )),
  "resource")

#' IUCN Red List of Threatened Species - Amphibians
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
#' @name iucn_amphibians
#' @docType data
#' @keywords resource
#' @format A global vector data set indicating species ranges
#' @references IUCN (2024). The IUCN Red List of Threatened Species. https://www.iucnredlist.org.
#' https://doi.org/10.1038/s41597-022-01284-8
#' @source \url{https://www.iucnredlist.org/resources/spatial-data-download}
NULL


#' @noRd
#' @include zzz.R
.get_iucn_amphibians <- function(
    x,
    path = NULL,
    rundir = tempdir(),
    verbose = TRUE) {

  if(is.null(path)){
    stop("'path' cannot be NULL.")
  }

  if(basename(path) != "AMPHIBIANS.zip"){
    stop("Expecting path to point towards a file called: 'AMPHIBIANS.zip'.")
  }

  dst <- file.path(rundir, gsub("zip", "fgb", basename(path)))
  src <- paste0("/vsizip/", path)
  if(!file.exists(dst)) .prep_iucn(src, dst, verbose = verbose)
  dst
}


.register(list(
  name = "iucn_amphibians",
  type = "vector",
  source = "https://www.iucnredlist.org/resources/spatial-data-download",
  fun = .get_iucn_amphibians,
  arguments = list(
    path = NULL
  )),
  "resource")


#' BirdLife International Species Ranges
#'
#' This resource is part of the spatial data set of bird ranges
#' released by BirdLife International. This resource is free to use under a
#' non-commercial licence. For commercial uses, a request has to be sent to
#' BirdLife International.
#'
#' To use this data in mapme workflows, you will have to manually download the
#' global data set and point towards the file path on your local machine.
#'
#' Note, that we are simplifying the species ranges polygons for better computational
#' efficiency.
#'
#' @name birdlife
#' @docType data
#' @keywords resource
#' @format A global vector data set indicating species ranges
#' @references BirdLife International and Handbook of the Birds of the World (2022).
#'   Bird species distribution maps of the world. Version 2022.2. Available at
#'   http://datazone.birdlife.org/species/requestdis
#' @source \url{http://datazone.birdlife.org/species/requestdis}
NULL


#' @noRd
#' @include zzz.R
.get_birdlife <- function(
    x,
    path = NULL,
    rundir = tempdir(),
    verbose = TRUE) {

  if(is.null(path)){
    stop("'path' cannot be NULL.")
  }

  if(basename(path) != "BOTW.gdb"){
    stop("Expecting path to point towards a file called: 'BOTW.gdb'.")
  }

  layers <- st_layers(path)
  polys_layer <- grep("Species", layers$name, value = TRUE)
  meta_layer <- grep("Species", layers$name, value = TRUE, invert = TRUE)
  if (length(polys_layer) != 1 || length(meta_layer) != 1) {
    stop("Expected 'birdlife' to have exactly two layers. Please raise an issue.")
  }
  sql <- sprintf("select * from %s inner join %s on %s.sisid=%s.sisid;",
                 polys_layer, meta_layer, polys_layer, meta_layer)
  dst <- file.path(rundir, gsub("gdb", "fgb", basename(path)))
  if(!file.exists(dst)) .prep_iucn(path, dst, sql, verbose)
  dst

}

.register(list(
  name = "birdlife",
  type = "vector",
  source = "http://datazone.birdlife.org/species/requestdis",
  fun = .get_birdlife,
  arguments = list(
    path = NULL
  )),
  "resource")


.prep_iucn <- function(src, dst, sql = NULL, verbose = TRUE) {

  opts <- c(
    "-makevalid",
    "-skipfailures",
    "-simplify", "0.01",
    "-nlt", "PROMOTE_TO_MULTI")
  if(!is.null(sql)) opts <- c(opts, "-dialect", "sqlite", "-sql", sql)
  if(verbose) opts <- c(opts, "-progress")

  sf::gdal_utils(
    "vectortranslate",
    source = src,
    destination = dst,
    quiet = FALSE,
    options = opts)
}

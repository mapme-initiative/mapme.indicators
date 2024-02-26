#' IUCN Red List of Threatened Species - Mammals
#'
#' This resource is part of the spatial data set Red List of Threatened Species
#' released by IUCN. The data are made available including taxonomic information,
#' distribution status, IUCN Red List Category, sources and other details. This
#' resource is free to use under a non-commercial licence. For commercial uses,
#' a request has to be sent to Integrated Biodiversity Assessment Tool (IBAT).
#' To use this data in mapme workflows, you will have to manually download the
#' global data set and point towards the file path on your local machine.
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


  dst <- gsub("zip", "gpkg", path)
  src <- paste0("/vsizip/", path)
  if(!file.exists(dst)) .iucn_to_gpkg(src, dst)
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
#' To use this data in mapme workflows, you will have to manually download the
#' global data set and point towards the file path on your local machine.
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

  dst <- gsub("zip", "gpkg", path)
  src <- paste0("/vsizip/", path)
  if(!file.exists(dst)) .iucn_to_gpkg(src, dst)
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
#' To use this data in mapme workflows, you will have to manually download the
#' global data set and point towards the file path on your local machine.
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

  dst <- gsub("zip", "gpkg", path)
  src <- paste0("/vsizip/", path)
  if(!file.exists(dst)) .iucn_to_gpkg(src, dst)
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
#' released by BirdLife International The data are made available including
#' taxonomic information,
#' distribution status, IUCN Red List Category, sources and other details. This
#' resource is free to use under a non-commercial licence. For commercial uses,
#' a request has to be sent to Integrated Biodiversity Assessment Tool (IBAT).
#' To use this data in mapme workflows, you will have to manually download the
#' global data set and point towards the file path on your local machine.
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

  dst <- gsub("gdb", "gpkg", path)
  if(!file.exists(dst)) .iucn_to_gpkg(path, dst)
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


.iucn_to_gpkg <- function(src, dst) {
  dTolerance <- 1000
  data <- read_sf(src)
  is_valid <- st_is_valid(data)

  valid <- data[is_valid, ]
  valid <- st_simplify(valid, preserveTopology = TRUE, dTolerance = dTolerance)

  if(sum(!is_valid) > 0) {
    try_valid <- data[!is_valid, ]
    try_valid <- st_make_valid(try_valid)
    is_valid <- st_is_valid(try_valid)
    try_valid <- try_valid[is_valid, ]
    try_valid <- st_simplify(try_valid, preserveTopology = TRUE, dTolerance = dTolerance)
    valid <- rbind(valid, try_valid)
  }

  st_write(valid, dst, delete_dsn = TRUE)
}

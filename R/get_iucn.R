#' IUCN Red List of Threatened Species
#'
#' This resource is part of the spatial data set Red List of Threatened Species
#' released by IUCN. It is free to use under a non-commercial licence. For
#' commercial uses, a request has to be sent to Integrated Biodiversity
#' Assessment Tool (IBAT).
#'
#' To use this data in mapme workflows, you will have to manually download the
#' global data set and point towards the file path on your local machine.
#' Please find the available data under the source link given below.
#'
#' @name iucn
#' @param path A character vector to the respective species range file in GTiff
#'   format. Note, that the file has to be downloaded manually.
#' @keywords resource
#' @returns A function that returns a character vector of file paths.
#' @references IUCN (2024). The IUCN Red List of Threatened Species.
#'   https://www.iucnredlist.org. \doi{https://doi.org/10.1038/s41597-022-01284-8 }
#' @source \url{https://www.iucnredlist.org/resources/other-spatial-downloads}
#' @importFrom tools file_ext
#' @export
get_iucn <- function(path = NULL) {

  if(is.null(path) || !file.exists(path) || file_ext(path) == "tif") {
    stop("Expecting path to point towards an existing GTiff file.")
  }

  function(
    x,
    name = "iucn",
    type = "raster",
    outdir = mapme_options()[["outdir"]],
    verbose = mapme_options()[["verbose"]],
    testing = mapme_options()[["testing"]]) {
    make_footprints(
      path,
      what = "raster",
      co = c("-co", "INTERLEAVE=BAND", "-co", "COMPRESS=LZW", "-ot", "Int8"))
  }
}

register_resource(
  name = "iucn",
  description = "IUCN Species Richness Raser Dataset",
  licence = "https://www.iucnredlist.org/terms/terms-of-use",
  source = "https://www.iucnredlist.org/resources/other-spatial-downloads",
  type = "raster"
)


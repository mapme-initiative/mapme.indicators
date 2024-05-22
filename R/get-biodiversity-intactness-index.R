#' Biodiversity Intactness Index
#'
#' The variable is the modeled average abundance of originally-present species,
#' relative to their abundance in an intact ecosystem. Please refer to
#' Newbold et al. (2016) for all details, and please cite it when using these
#' data.
#'
#' To use this data in mapme workflows, you will have to manually download the
#' global data set and point towards the file path on your local machine.
#' Please find the available data under the source link given below.
#'
#' @name bii
#' @param path A character vector to the biodiversity intactness index tif file.
#'   Note, that the file has to be downloaded manually.
#' @keywords resource
#' @returns A function that returns a character vector of file paths.
#' @references Tim Newbold; Lawrence Hudson; Andy Arnell; Sara Contu et al. (2016). Global map of the Biodiversity Intactness Index, from Newbold et al. (2016) Science [Data set]. Natural History Museum. \doi{https://doi.org/10.5519/0009936}
#' @source \url{https://data.nhm.ac.uk/dataset/global-map-of-the-biodiversity-intactness-index-from-newbold-et-al-2016-science}
#' @export
get_biodiversity_intactness_index <- function(path = NULL) {

  if(is.null(path) || !file.exists(path)) {
    stop("Expecting path to point towards an existing file.")
  }

  function(
    x,
    name = "bii",
    type = "raster",
    outdir = mapme_options()[["outdir"]],
    verbose = mapme_options()[["verbose"]],
    testing = mapme_options()[["testing"]]) {
    make_footprints(
      path,
      what = "raster",
      co = c("-co", "INTERLEAVE=BAND", "-co", "COMPRESS=LZW", "-ot", "Float32"))
  }
}

register_resource(
  name = "bii",
  description = "Biodiversity Intactness Index",
  licence = "CC-BY-4.0",
  source = "https://data.nhm.ac.uk/dataset/global-map-of-the-biodiversity-intactness-index-from-newbold-et-al-2016-science",
  type = "raster"
)

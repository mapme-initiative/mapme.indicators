#' World Dataset of Free Flowing Rivers
#'
#' This resource is part of the publication by Grill et al. (2019) "Mapping the
#' world’s free-flowing rivers" and represents a global data set of the HydroSHEDS
#' river network data enriched with information about pressures caused by
#' human-made infrastructure such as fragmentation, regulation, sediment trapping,
#' water consumpations among others.
#'
#' @name free_flowing_rivers
#' @docType data
#' @keywords resource
#' @format A global vector data set of line segments
#' @references Grill, G., Lehner, B., Thieme, M. et al. Mapping the world’s
#' free-flowing rivers. Nature 569, 215–221 (2019). https://doi.org/10.1038/s41586-019-1111-9
#' @source \url{https://figshare.com/articles/dataset/Mapping_the_world_s_free-flowing_rivers_data_set_and_technical_documentation/7688801}
NULL

#' @noRd
#' @include zzz.R
.get_ffrivers <- function(
    x,
    rundir = tempdir(),
    verbose = TRUE) {

  baseurl <- "https://api.figshare.com/v2/articles/7688801/files"
  cnt <- resp_body_json(req_perform(request(baseurl)))
  data <- lapply(cnt, function(x) data.frame(filename = x[["name"]], url = x[["download_url"]]))
  data <- do.call(rbind, data)
  data <- data[grep("zip", data[["filename"]]), ]
  url <- data[["url"]]
  filename <- file.path(rundir, "free_flowing_rivers")

  zip <- paste0(filename, ".zip")
  gpkg <- paste0(filename, ".gpkg")

  if(attributes(x)[["testing"]]) return(gpkg)
  aria_bin <- attributes(x)$aria_bin

  mapme.biodiversity:::.download_or_skip(
    url,
    zip,
    check_existence = FALSE,
    aria_bin = aria_bin)

  cnt <- unzip(zip, list = TRUE)
  gdb <- cnt$Name[1]
  sf::gdal_utils(util = "vectortranslate",
                 source = file.path("/vsizip", zip, gdb),
                 destination = gpkg,
                 options = c("-nln", "free_flowing_rivers"))
  gpkg

}

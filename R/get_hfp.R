#' Terrestrial Human Foootprint
#'
#' This resource is part of the publication by Mu et al. (2022) "A global
#' record of annual terrestrial Human Footprint dataset from 2000 to 2018".
#' It is calculated based on 8 variables representing human pressures on
#' natural ecosystems collected at a yearly cadence between 2000 and 2020
#' sampled at a 1km spatial resolution. The variables are used are
#' the expansion of built environments (expressed as percentage of built-up
#' areas within a grid cell), population density (aggregated at the gridd cell),
#' nighttime lights, crop and pasture lands, roads and railways (excluding trails
#' and minor roads), and navigable waterways (compares waterways with nighttime
#' lights dataset). The human footprint was then calculated based on a weighting
#' scheme proposed by Venter et al. (2016), assigning each pixel a value between
#' 0 and 50, with 50 representing the theoretical value of the highest human
#' pressure.
#'
#' It may be required to increase the timeout option to successfully download
#' theses layers from their source location via e.g. `options(timeout = 600)`.
#'
#' @name humanfootprint
#' @param years A numeric vector indicating the years for which to download
#'   the human footprint data, defaults to \code{2000:2020}.
#' @keywords resource
#' @returns A function that returns a character vector of file paths.
#' @references Mu, H., Li, X., Wen, Y. et al. A global record of annual
#' terrestrial Human Footprint dataset from 2000 to 2018. Sci Data 9, 176 (2022).
#' \doi{https://doi.org/10.1038/s41597-022-01284-8}
#' @source \url{https://figshare.com/articles/figure/An_annual_global_terrestrial_Human_Footprint_dataset_from_2000_to_2018/16571064}
#' @importFrom mapme.biodiversity check_available_years
#' @importFrom utils unzip download.file
#' @export
get_humanfootprint <- function(years = 2000:2020) {

  available_years <- 2000:2020
  years <- check_available_years(
    years, available_years, "humanfootprint"
  )

  if (is.null(mapme_options()[["outdir"]])) {
    warning(paste("humanfootprint layers must be downloaded from the source location",
                  "irrespective if `outdir` was specified or not."))
  }

  function(
    x,
    name = "humanfootprint",
    type = "raster",
    outdir = mapme_options()[["outdir"]],
    verbose = mapme_options()[["verbose"]]) {

    srcs <- .get_hfp_url(years)
    has_outdir <- !is.null(outdir)
    if (has_outdir) {
      dsts <- file.path(outdir, srcs[["filename"]])
    } else {
      dsts <- file.path(tempdir(), srcs[["filename"]])
    }
    dsts <- gsub("zip", "tif", dsts)
    is_available <- purrr::map_lgl(dsts, spds_exists, what = "raster")
    if (all(is_available)) {
      return(make_footprints(dsts, what = "raster"))
    }

    dsts <- purrr::map2_chr(srcs[["url"]], dsts, function(src, dst) {
      if (!spds_exists(dst, what = "raster")) {
        tmp <- file.path(tempdir(), gsub(".tif", ".zip", basename(dst)))
        download.file(src, tmp, mode = ifelse(Sys.info()["sysname"] == "Windows", "wb", "w"))
        unzip(tmp, exdir = tempdir())
        return(file.path(tempdir(), basename(dst)))
      } else {
        return(dst)
      }
    })

    make_footprints(
      dsts,
      what = "raster",
      co = c("-of", "COG", "-co", "COMPRESS=LZW", "-ot", "Float32"))
  }
}

#' @noRd
#' @importFrom httr2 request req_perform resp_body_json
.get_hfp_url <- function(years) {
  baseurl <- "https://api.figshare.com/v2/articles/16571064/files"
  cnt <- resp_body_json(req_perform(request(baseurl)))
  data <- lapply(cnt, function(x) data.frame(filename = x[["name"]], url = x[["download_url"]]))
  data <- do.call(rbind, data)
  data <- data[grep("zip", data[["filename"]]), ]
  data["year"] <- as.numeric(substring(data[["filename"]], 4, 7))
  data[data[["year"]] %in% years, ]
}

register_resource(
  name = "humanfootprint",
  description = "Time series on human pressures on natural ecosystems.",
  licence = "CC BY 4.0",
  source = "https://figshare.com/articles/figure/An_annual_global_terrestrial_Human_Footprint_dataset_from_2000_to_2018/16571064",
  type = "raster"
)



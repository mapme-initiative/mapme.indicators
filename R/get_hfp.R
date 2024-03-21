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
#' @name humanfootprint
#' @docType data
#' @keywords resource
#' @format A global tiled raster resource available for all land areas.
#' @references Mu, H., Li, X., Wen, Y. et al. A global record of annual
#' terrestrial Human Footprint dataset from 2000 to 2018. Sci Data 9, 176 (2022).
#' https://doi.org/10.1038/s41597-022-01284-8
#' @source \url{https://figshare.com/articles/figure/An_annual_global_terrestrial_Human_Footprint_dataset_from_2000_to_2018/16571064}
NULL


#' @noRd
#' @include zzz.R
.get_hfp <- function(
    x,
    rundir = tempdir(),
    verbose = TRUE) {

  target_years <- attributes(x)$years
  available_years <- 2000:2020
  target_years <- mapme.biodiversity:::.check_available_years(
    target_years, available_years, "humanfootprint"
  )

  urls_df <- .get_hfp_url(target_years)
  filenames <- file.path(rundir, urls_df[["filename"]])
  if(attributes(x)[["testing"]]) return(filenames)

  aria_bin <- attributes(x)$aria_bin
  zips <- mapme.biodiversity:::.download_or_skip(
    urls_df[["url"]],
    filenames,
    verbose,
    check_existence = FALSE,
    aria_bin)

  purrr::walk(zips, function(zip) mapme.biodiversity:::.unzip_and_remove(zip, rundir, remove = FALSE))
  file.path(rundir, paste0(substring(basename(zips), 1, 8), "tif"))
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

.register(list(
  name = "humanfootprint",
  type = "raster",
  source = "https://figshare.com/articles/figure/An_annual_global_terrestrial_Human_Footprint_dataset_from_2000_to_2018/16571064",
  fun = .get_hfp,
  arguments = list()),
  "resource")


#' Terrestrial Human Foootprint
#'
#' This resource is part of the publication by Mu et al. (2022) "A global
#' record of annual terrestrial Human Footprint dataset from 2000 to 2018".
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
  cnt <- request(baseurl) |> req_perform() |> resp_body_json()
  data <- lapply(cnt, function(x) data.frame(filename = x[["name"]], url = x[["download_url"]]))
  data <- do.call(rbind, data)
  data <- data[grep("zip", data[["filename"]]), ]
  data["year"] <- substring(data[["filename"]], 4, 7) |> as.numeric()
  data[data[["year"]] %in% years, ]
}


#' Global Surface Water - Yearly Time Series
#'
#' This resource is part of the JRC Global Surface Water dataset. It provides
#' yearly categorical raster data on terrestrial surface water classes.
#'
#' @details
#' The available surface water classes for a given pixel are the following:
#'
#' - No Observation: It was not possible to determine whether a pixel was water
#' (this may be the case for frozen areas or during the polar night in extreme
#' latitudes).
#' - Permanent Water: Water was detected in twelve months per year or in a
#' combination of permanent and no observation.
#' - Seasonal Water: Water and no water was detected.
#' - No Water: No Water was detected.
#'
#' @name gsw_time_series
#' @docType data
#' @keywords resource
#' @format A global tiled raster resource available for all terrestrial areas, available yearly for 1984 -- 2021.
#' @references
#' * Global Surface Water Explorer: \url{https://global-surface-water.appspot.com/}
#' * Data Users Guide: \url{https://storage.cloud.google.com/global-surface-water/downloads_ancillary/DataUsersGuidev2021.pdf}
#' * Research Article: \url{https://www.nature.com/articles/nature20584}
#' @source Raw Data: \url{https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/GSWE/YearlyClassification/LATEST/tiles/}
NULL

#' Helper function to download Global Surface Water (GSW) yearly time series
#' data
#'
#' This function constructs for a given dataset version and polygon extent the
#' needed data URLs and downloads them for further processing with the
#' mapme.biodiversity package.
#'
#' @param x A sf portfolio object as returned by
#' mapme.biodiversity::init_portfolio.
#' @param version Version of the data set to process. Default:
#' "LATEST".
#' @param rundir A directory where intermediate files are written to. Default:
#' tempdir().
#' @param verbose Logical to control output verbosity. Default: TRUE.
#' @noRd
get_gsw_time_series <- function(years, version = "LATEST") {
  available_versions = c("VER1-0", "VER2-0", "VER3-0", "VER4-0", "VER5-0",
                         "LATEST")
  available_years <- 1984:2021
  years <- check_available_years(years, available_years, "gsw_time_series")
  stopifnot(version %in% available_versions)

  function(x,
           name = "gsw_time_series",
           type = "raster",
           outdir = mapme_options()[["outdir"]],
           verbose = mapme_options()[["verbose"]],
           testing = mapme_options()[["testing"]]) {
    # make the gsw grid and construct urls for intersecting tiles
    baseurl <- sprintf(
      "/vsicurl/https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/GSWE/YearlyClassification/%s/tiles/",
      version
    )
    grid_gsw <- make_global_grid(
      xmin = -180, xmax = 180, dx = 10,
      ymin = -60, ymax = 80, dy = 10
    )
    tile_ids <- unique(unlist(st_intersects(x, grid_gsw)))
    if (length(tile_ids) == 0) {
      stop("The extent of the portfolio does not intersect with the GSW grid.",
           call. = FALSE
      )
    }
    ids <- sapply(tile_ids, function(n) .get_gsw_ts_tile_id(grid_gsw[n, ]))

    source_combinations <- expand.grid(years = years, ids = ids)
    urls <- purrr::map2_chr(source_combinations$years, source_combinations$ids, \(year, tile_url_id) {
        # Warning: file naming system is different for 2021
        separator <- ifelse(year == 2021, "_", "-")
        sprintf(
          "%syearlyClassification%s/yearlyClassification%s%s%s.tif",
          baseurl, year, year, separator, tile_url_id
        )
    })

    fps <- grid_gsw[expand.grid(years, tile_ids = tile_ids)$tile_ids, ]
    fps[["source"]] <- urls
    make_footprints(fps,
      filenames = paste0(version, "_", basename(fps$source)),
      what = "raster",
      co = c("-co", "INTERLEAVE=BAND", "-co", "COMPRESS=LZW", "-ot", "Byte")
    )
  }
}

.get_gsw_ts_tile_id <- function(tile) {
  min_x <- st_bbox(tile)[1]
  max_y <- st_bbox(tile)[4]

  x_idx <- which(seq(-180, 170, by = 10) == min_x) - 1
  y_idx <- which(seq(80, -50, by = -10) == max_y) - 1

  tile_id <- sprintf(
    "%010d-%010d",
    y_idx * 40000,
    x_idx * 40000
  )

  return(tile_id)
}

register_resource(
  name = "gsw_time_series",
  description = "Global Surface Water - Yearly Time Series",
  licence = "https://global-surface-water.appspot.com/download",
  source = "https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/GSWE/YearlyClassification/LATEST/tiles/",
  type = "raster"
)

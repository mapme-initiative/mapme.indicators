#' Calculate human footprint statistics
#'
#' Human footprint data measures the pressure imposed on the natural environment
#' by different dimensions of human actions. The theoretical maximum value,
#' representing the highest level of human pressure, is 50. This routine allows
#' to extract zonal statistics of the human footprint data.
#'
#' The required resources for this indicator are:
#'  - [humanfootprint]
#'
#' @name humanfootprint_stats
#' @docType data
#' @keywords indicator
#' @format A tibble with a column for each statistic and a row for every
#'   requested year.
NULL

#' @noRd
#' @include zzz.R
.calc_hfp <- function(
    x,
    humanfootprint,
    engine = "extract",
    stats_hfp = "mean",
    verbose = TRUE,
    ...) {

  if (is.null(humanfootprint)) {
    return(NA)
  }

  x <- st_transform(x, st_crs(humanfootprint))
  result <- mapme.biodiversity:::.select_engine(
    x = x,
    raster = humanfootprint,
    stats = stats_hfp,
    engine = engine,
    name = "humanfootprint",
    mode = "asset"
  )
  result[["year"]] <- substring(names(humanfootprint), 4, 7)
  result
}

.register(list(
  name = "humanfootprint_stats",
  resources = list(humanfootprint = "raster"),
  fun = .calc_hfp,
  arguments = list(
    engine = "extract",
    stats_hfp = "mean"
  ),
  processing_mode = "asset"),
  "indicator")

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
#' @name humanfootprint
#' @param engine The preferred processing functions from either one of "zonal",
#'   "extract" or "exactextract" as character.
#' @param stats Function to be applied to compute statistics for polygons either
#'   one or multiple inputs as character. Supported statistics are: "mean",
#'   "median", "sd", "min", "max", "sum" "var".
#' @keywords indicator
#' @returns A function that returns a tibble with a column for each statistic
#'   and a row for every requested year.
#' @importFrom mapme.biodiversity check_engine check_stats select_engine
#' @export
calc_humanfootprint <- function(engine = "extract", stats = "mean") {

  engine <- check_engine(engine)
  stats <- check_stats(stats)

  function(
    x,
    humanfootprint,
    name = "humanfootprint",
    mode = "asset",
    aggregation = "stat",
    verbose = mapme_options()[["verbose"]]) {

    if (is.null(humanfootprint)) {
      return(NULL)
    }

    x <- st_transform(x, st_crs(humanfootprint))
    result <- select_engine(
      x = x,
      raster = humanfootprint,
      stats = stats,
      engine = engine,
      name = "humanfootprint",
      mode = "asset"
    )
    years <- as.numeric(substring(names(humanfootprint), 4, 7))
    result[["datetime"]] <- as.Date(paste0(years, "-01-01"))
    result <- tidyr::pivot_longer(result, cols = -datetime, names_to = "variable")
    result[["unit"]] <- "unitless"
    result[ ,c("datetime", "variable", "unit", "value")]
  }
}

register_indicator(
  name = "humanfootprint",
  description = "Statistics of the human footprint data set per polygon.",
  resources = "humanfootprint"
)

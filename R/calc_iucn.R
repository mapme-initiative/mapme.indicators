#' Species richness based on IUCN raster data
#'
#' Species richness counts the number of potential species intersecting with a
#' polygon grouped by the IUCN threat categorization. Note, that
#' this indicator function requires the manual download of the respective
#' raster files.
#'
#' The specific meaning of the species richness indicator depends on the
#' supplied raster file.
#'
#' The required resources for this indicator are:
#'  - [iucn]
#'
#' @name species_richness
#' @param engine The preferred processing functions from either one of "zonal",
#'   "extract" or "exactextract" as character.
#' @param stats Function to be applied to compute statistics for polygons either
#'   one or multiple inputs as character. Supported statistics are: "mean",
#'   "median", "sd", "min", "max", "sum" "var".
#' @keywords indicator
#' @returns A function that returns an indicator tibble with IUCN layers with
#'   specified statistics as variable and respective values as value.
#' @export
calc_species_richness <- function(engine = "extract", stats = "mean") {
  engine <- check_engine(engine)
  stats <- check_stats(stats)

  function(
    x,
    iucn,
    name = "species_richness",
    mode = "asset",
    aggregation = "stat",
    verbose = mapme_options()[["verbose"]]) {

    if (is.null(iucn)) {
      return(NULL)
    }

    if (all(unlist(global(noNA(iucn), fun = "sum")) == 0)) {
      return(NULL)
    }

    x <- st_transform(x, st_crs(iucn))

    result <- select_engine(
      x = x,
      raster = iucn,
      stats = stats,
      engine = engine,
      name = "",
      mode = "asset"
    )

    result[["variable"]] <- gsub(".tif", "", names(iucn))
    result <- tidyr::pivot_longer(result, -variable, names_to = "stats")
    result[["variable"]] <- paste0(tolower(result[["variable"]]), result[["stats"]])
    result[["value"]][is.na(result[["value"]])] <- 0
    year <- as.numeric(gsub("\\D", "", names(iucn)))
    result[["datetime"]] <-  as.POSIXct(paste0(year, "-01-01T00:00:00Z"))
    result[["unit"]] <- "count"
    result[ ,c("datetime", "variable", "unit", "value")]
  }
}

register_indicator(
  name = "species_richness",
  description = "Species richness statistics based on user-specified raster files.",
  resources = "iucn"
)

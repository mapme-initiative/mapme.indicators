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
#' @param variable A character used as the variable column output. Defaults to
#'   `species_richness` but can be set to reflect the manually specified raster
#'   file.
#' @keywords indicator
#' @returns A function that returns a tibble with statistics on the species
#'   richness.
#' @export
calc_species_richness <- function(engine = "extract", stats = "mean",
                                  variable = "species_richness") {
  engine <- check_engine(engine)
  stats <- check_stats(stats)
  stopifnot(is.character(variable) || length(variable) == 1)

  function(
    x,
    iucn,
    name = "species_richness",
    mode = "asset",
    aggregation = "stat",
    verbose = mapme_options()[["verbose"]]) {

    x <- st_transform(x, st_crs(iucn))

    result <- select_engine(
      x = x,
      raster = iucn,
      stats = stats,
      engine = engine,
      name = variable,
      mode = "asset"
    )
    datetime <- strsplit(names(iucn), "_")[[1]]
    result[["datetime"]] <-  as.Date(paste0(rev(datetime)[1], "-01-01"))
    result <- tidyr::pivot_longer(result, cols = -datetime, names_to = "variable")
    result[["unit"]] <- "count"
    result[ ,c("datetime", "variable", "unit", "value")]
  }
}

register_indicator(
  name = "species_richness",
  description = "Species richness statistics based on user-specified raster files.",
  resources = "iucn"
)

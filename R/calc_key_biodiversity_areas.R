#' Calculate Key Biodiversity Areas
#'
#' This function calculates the total area of key biodiversity areas for a given
#' input polygon.
#'
#' The required resources for this indicator are:
#'  - [key_biodiversity_areas]
#'
#' @name key_biodiversity_areas
#' @docType data
#' @keywords indicator
#' @format A function returning a tibble with the key biodiversity area overlap
#' @export
calc_key_biodiversity_area <- function() {
  function(x = NULL,
           key_biodiversity_areas,
           name = "key_biodiversity_areas",
           mode = "asset",
           aggregation = "mean",
           verbose = mapme_options()[["verbose"]]) {

    key_biodiversity_areas <- key_biodiversity_areas[[1]]
    if (is.null(key_biodiversity_areas) | nrow(key_biodiversity_areas) == 0) {
      return(NULL)
    }

    int_area <- suppressWarnings(st_intersection(x, key_biodiversity_areas))
    int_area_ha <- as.numeric(sum(st_area(int_area), na.rm = TRUE) / 10000)

    results <- tibble::tibble(
      datetime = as.POSIXct("2024-01-01T00:00:00Z"),
      variable = "key_biodiversity_area",
      unit = "ha",
      value = int_area_ha
    )

    return(results)
  }
}

register_indicator(
  name = "key_biodiversity_areas",
  description = "Area estimation of intersection with key biodiversity areas.",
  resources = "key_biodiversity_areas"
)

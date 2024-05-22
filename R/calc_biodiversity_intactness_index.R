#' Calculate Biodiversity Intactness Index
#'
#' This function calculates the mean biodiversity intactness index for a region.
#'
#' The required resources for this indicator are:
#'  - [biodiversity_intactness_index]
#'
#' @name biodiversity_intactness_index
#' @docType data
#' @keywords indicator
#' @format A function returning a tibble with the aggregated biodiversity
#' intactness index.
NULL

#' @noRd
calc_biodiversity_intactness_index <- function() {
  check_namespace("exactextractr")
  function(x = NULL,
           biodiversity_intactness_index,
           name = "biodiversity_intactness_index",
           mode = "asset",
           aggregation = "mean",
           verbose = mapme_options()[["verbose"]]) {

    if (is.null(biodiversity_intactness_index)) {
      return(NULL)
    }

    mean_bii <- exactextractr::exact_extract(biodiversity_intactness_index, x, fun = "mean")

    results <- tibble::tibble(
      datetime = "2016-01-01",
      variable = "Biodiversity intactness index (mean)",
      unit = NA,
      value = mean_bii
    )

    return(results)
  }
}

register_indicator(
  name = "biodiversity_intactness_index",
  description = "Biodiversity intactness index (mean)",
  resources = "biodiversity_intactness_index"
)

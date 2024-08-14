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
#' @export
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

    if (all(unlist(global(noNA(biodiversity_intactness_index), fun = "sum")) == 0)) {
      return(NULL)
    }

    mean_bii <- exactextractr::exact_extract(biodiversity_intactness_index, x, fun = "mean")

    results <- tibble::tibble(
      datetime = as.POSIXct("2005-01-01T00:00:00Z"),
      variable = "biodiversity_intactness_index",
      unit = "unitless",
      value = mean_bii
    )

    return(results)
  }
}

register_indicator(
  name = "biodiversity_intactness_index",
  description = "Averaged biodiversity intactness index.",
  resources = "biodiversity_intactness_index"
)

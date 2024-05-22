#' Calculate Biodiversity Intactness Index
#'
#' This function calculates the mean biodiversity intactness index for a region.
#'
#' The required resources for this indicator are:
#'  - [bii]
#'
#' @name biodiversity_intactness_index
#' @docType data
#' @keywords indicator
#' @format A function returning a tibble with the aggregated biodiversity
#' intactness index.
NULL

#' @noRd
calc_biodiversity_intactness_index <- function() {
  function(x = NULL,
           bii,
           name = "biodiversity_intactness_index",
           mode = "asset",
           aggregation = "mean",
           verbose = mapme_options()[["verbose"]]) {

    if (is.null(bii)) {
      return(NULL)
    }

    bii <- mask(
      bii,
      x
    )

    mean_bii <- mean(values(bii), na.rm = TRUE)
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
  resources = "bii"
)

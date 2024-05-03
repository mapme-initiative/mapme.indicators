#' Calculate areal statistics for IBPES Biomes
#'
#' This indicator calculates the areal distribution of different biome classes
#' within an asset based on the IBPES biomes dataset.
#'
#' The required resources for this indicator are:
#'  - [ipbes]
#'
#' @name ipbes_biome_stats
#' @keywords indicator
#' @returns A function that returns a tibble with columns for the class name,
#'   its absolute and relative coverage within an asset.
#' @export
calc_ipbes_biome <- function() {

  function(
    x,
    ipbes_biome,
    name = "ipbes_biome_stats",
    mode = "portfolio",
    verbose = mapme_options()[["verbose"]]) {

    if (is.null(ipbes_biome)) return(NA)

    results <- lapply(1:nrow(x), function(i) {
      exactextractr::exact_extract(ipbes_biome, x[i, ], fun = function(data, class_df){

        data[["coverage_area"]] <- data[["coverage_area"]] / 10000
        total_area <- sum(data[["coverage_area"]])
        class_area <- by(data[["coverage_area"]], data[["value"]], sum)
        result <- tibble::tibble(
          class = as.numeric(names(class_area)),
          area = as.numeric(class_area),
          percentage = as.numeric(class_area) / total_area * 100
        )
        result[["class"]] <- class_df[["name"]][result[["class"]]]
        result

      }, class_df = ipbes_biome_classes, coverage_area = TRUE, summarize_df = TRUE)
    })

    results
  }
}

register_indicator(
  name = "ipbes_biome_stats",
  description = "Area distibution of IBPES biomes within a polygon.",
  resources = "ipbes_biome"
)

#' Calculate areal statistics for IBPES Anthromes
#'
#' This indicator calculates the areal distribution of the two different anthrome
#' classes within an asset based on the IBPES anthrome dataset. You can select
#' to only include areal statistics for built-up areas, cultivated areas, or both.
#'
#' The required resources for this indicator are:
#'  - [ipbes]
#'
#' @name ipbes_anthrome_stats
#' @param anthrome One of "urban_areas", "cultivated_areas", "both". Determines
#'     for which data layer the areal statistics are calculated.
#' @keywords indicator
#' @returns A function that returns a tibble with columns for the respective
#'  anthrome name, the affected area, the percentage of the affected area in
#'  relation to the total area, and the total area (all expressed in ha).
#' @export
calc_ipbes_anthrome <- function(anthrome = c("urban_areas", "cultivated_areas", "both")) {

  anthrome <- match.arg(anthrome)

  function(
    x,
    ipbes_anthrome,
    name = "ipbes_anthrome_stats",
    mode = "portfolio",
    verbose = mapme_options()[["verbose"]]) {

    if (is.null(ipbes_anthrome)) return(NA)
    if (anthrome == "both") anthrome <- c("urban_areas", "cultivated_areas")
    names(ipbes_anthrome) <- c("urban_areas", "cultivated_areas")
    ipbes_anthrome <- ipbes_anthrome[[anthrome]]

    results <- lapply(1:nrow(x), function(i) {
      exactextractr::exact_extract(ipbes_anthrome, x[i, ], fun = function(data, anthrome){

        data[["coverage_area"]] <- data[["coverage_area"]] / 10000
        result <- lapply(anthrome, function(a){
          affected <- sum((data[[a]]/100) * data[["coverage_area"]])
          total = sum(data[["coverage_area"]])
          percent = affected / total * 100
          tibble::tibble(
            anthrome = a,
            affected = affected,
            percentage = percent,
            total = total
          )
        })
        do.call(rbind, result)

      }, anthrome = anthrome, coverage_area = TRUE, summarize_df = TRUE)
    })
    results
  }
}

register_indicator(
  name = "ipbes_anthrome_stats",
  description = "Area distibution of IBPES anthrome classes within a polygon.",
  resources = "ipbes_biome"
)

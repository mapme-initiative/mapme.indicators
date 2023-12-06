#' Calculate areal statistics for IBPES Biomes
#'
#' This indicator calculates the areal distribution of different biome classes
#' within an asset based on the IBPES biomes dataset.
#'
#' The required resources for this indicator are:
#'  - [ipbes_biome]
#'
#' @name ipbes_biome_stats
#' @docType data
#' @keywords indicator
#' @format A tibble with columns for the class name, its absolute and relative
#'   coverage within an asset.
NULL

#' @include zzz.R
.calc_ipbes_biome <- function(
    x,
    ipbes_biome,
    verbose = TRUE) {

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

.register(list(
  name = "ipbes_biome_stats",
  resources = list(ipbes_biome = "raster"),
  fun = .calc_ipbes_biome,
  arguments = list(),
  processing_mode = "portfolio"),
  "indicator")


#' Calculate areal statistics for IBPES Anthromes
#'
#' This indicator calculates the areal distribution of the two different anthrome
#' classes within an asset based on the IBPES anthrome dataset. You can select
#' to only include areal statistics for built-up areas, cultivated areas, or both.
#'
#' The required resources for this indicator are:
#'  - [ipbes_anthrome]
#'
#' The following argument can be set:
#' \describe{
#'   \item{anthrome}{One of "urban_areas", "cultivated_areas", "both". Determines
#'     for which data layer the areal statistics are calculated.}
#' }
#'
#' @name ipbes_anthrome_stats
#' @docType data
#' @keywords indicator
#' @format A tibble with columns for the respective anthrome name, the affected
#'   area, the percentage of the affected area in relation to the total area,
#'   and the total area (all expressed in ha).
NULL

#' @include zzz.R
.calc_ipbes_anthrome <- function(
    x,
    ipbes_anthrome,
    anthrome = c("urban_areas", "cultivated_areas", "both"),
    verbose = TRUE) {

  anthrome <- match.arg(anthrome)
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

.register(list(
  name = "ipbes_anthrome_stats",
  resources = list(ipbes_anthrome = "raster"),
  fun = .calc_ipbes_anthrome,
  arguments = list(anthrome = "both"),
  processing_mode = "portfolio"),
  "indicator")



#' Calculate irrecoverable carbon statistics
#'
#' Irrecoverable carbon is the amount of carbon that, if lost today, could not
#' be recovered until 2050. It can be calculated for above- and below-ground
#' carbon, the total amount of carbon, or for all layers.
#'
#' The required resources for this indicator are:
#'  - [irr_carbon]
#'
#' The following argument can be set:
#' \describe{
#'   \item{which_carbon}{One of "total", "soil", "biomass", "all". Determines
#'     for which data layer the statistics are calculated.}
#'  \item{stats_carbon}{Function to be applied to compute statistics for polygons either
#'   one or multiple inputs as character. Supported statistics are: "mean",
#'   "median", "sd", "min", "max", "sum" "var".}
#'  \item{engine}{The preferred processing functions from either one of "zonal",
#'   "extract" or "exactextract" as character.}
#' }
#'
#' @name irr_carbon
#' @docType data
#' @keywords indicator
#' @format A tibble with a column for each statistic and rows for every year
#'   and type of carbon.
NULL

#' @include zzz.R
.calc_irr_carbon <- function(
    x,
    irr_carbon,
    which_carbon = c("total", "soil", "biomass", "all"),
    stats_carbon = "mean",
    engine = "extract",
    verbose = TRUE) {

  which_carbon <- match.arg(which_carbon)

  .calc_carbon_stats(
    x,
    layer = irr_carbon,
    which_layer = which_carbon,
    stats = stats_carbon,
    engine = engine,
    name = "irr_carbon",
    mode = "asset"
  )

}

.register(list(
  name = "irr_carbon",
  resources = list(irr_carbon = "raster"),
  fun = .calc_irr_carbon,
  arguments = list(
    which_carbon = "total",
    stats_carbon = "mean",
    engine = "extract"
  ),
  processing_mode = "asset"),
  "indicator")


#' Calculate manageable carbon statistics
#'
#' Manageable carbon is the amount of carbon that, in principle, is manageable
#' by human activities, e.g. its release to the atmosphere can be prevented.
#' It can be calculated for above- and below-ground carbon, the total amount
#' of carbon, or for all layers.
#'
#' The required resources for this indicator are:
#'  - [man_carbon]
#'
#' The following argument can be set:
#' \describe{
#'   \item{which_carbon}{One of "total", "soil", "biomass", "all". Determines
#'     for which data layer the statistics are calculated.}
#'  \item{stats_carbon}{Function to be applied to compute statistics for polygons either
#'   one or multiple inputs as character. Supported statistics are: "mean",
#'   "median", "sd", "min", "max", "sum" "var".}
#'  \item{engine}{The preferred processing functions from either one of "zonal",
#'   "extract" or "exactextract" as character.}
#' }
#'
#' @name man_carbon
#' @docType data
#' @keywords indicator
#' @format A tibble with a column for each statistic and rows for every year
#'   and type of carbon.
NULL

#' @include zzz.R
.calc_man_carbon <- function(
    x,
    man_carbon,
    which_carbon = c("total", "soil", "biomass", "all"),
    stats_carbon = "mean",
    engine = "extract",
    verbose = TRUE) {

  which_carbon <- match.arg(which_carbon)

  .calc_carbon_stats(
    x,
    layer = man_carbon,
    which_layer = which_carbon,
    stats = stats_carbon,
    engine = engine,
    name = "man_carbon",
    mode = "asset"
  )
}


.register(list(
  name = "man_carbon",
  resources = list(man_carbon = "raster"),
  fun = .calc_man_carbon,
  arguments = list(
    which_carbon = "total",
    stats_carbon = "mean",
    engine = "extract"
  ),
  processing_mode = "asset"),
  "indicator")


#' Vulnerable manageable carbon statistics
#'
#' Vulnerable carbon is the amount of carbon that would be released in a typical
#' land conversion activity.
#' It can be calculated for above- and below-ground carbon, the total amount
#' of carbon, or for all layers.
#'
#' The required resources for this indicator are:
#'  - [vul_carbon]
#'
#' The following argument can be set:
#' \describe{
#'   \item{which_carbon}{One of "total", "soil", "biomass", "all". Determines
#'     for which data layer the statistics are calculated.}
#'  \item{stats_carbon}{Function to be applied to compute statistics for polygons either
#'   one or multiple inputs as character. Supported statistics are: "mean",
#'   "median", "sd", "min", "max", "sum" "var".}
#'  \item{engine}{The preferred processing functions from either one of "zonal",
#'   "extract" or "exactextract" as character.}
#' }
#'
#' @name vul_carbon
#' @docType data
#' @keywords indicator
#' @format A tibble with a column for each statistic and rows for every year
#'   and type of carbon.
NULL

#' @include zzz.R
.calc_vul_carbon <- function(
    x,
    vul_carbon,
    which_carbon = c("total", "soil", "biomass", "all"),
    stats_carbon = "mean",
    engine = "extract",
    verbose = TRUE) {

  which_carbon <- match.arg(which_carbon)

  .calc_carbon_stats(
    x,
    layer = vul_carbon,
    which_layer = which_carbon,
    stats = stats_carbon,
    engine = engine,
    name = "vul_carbon",
    mode = "asset"
  )
}


.register(list(
  name = "vul_carbon",
  resources = list(vul_carbon = "raster"),
  fun = .calc_vul_carbon,
  arguments = list(
    which_carbon = "total",
    stats_carbon = "mean",
    engine = "extract"
  ),
  processing_mode = "asset"),
  "indicator")

.calc_carbon_stats <- function(
    x,
    layer,
    which_layer = c("total", "soil", "biomass", "all"),
    stats = "mean",
    engine = "extract",
    name = NULL,
    mode = "asset") {

  if (is.null(layer)) return(NA)

  if (which_layer == "all") which_layer <- c("total", "soil", "biomass")
  names(layer) <- tolower(names(layer))
  layer <- layer[[grep(paste(which_layer, collapse = "|"), names(layer))]]

  result <- mapme.biodiversity:::.select_engine(
    x = x,
    raster = layer,
    stats = stats,
    engine = engine,
    name = name,
    mode = mode
  )

  type <- sapply(strsplit(names(layer), "_"), function(x) x[3])
  year <- sapply(strsplit(names(layer), "_"), function(x) as.numeric(x[4]))

  result[["type"]] <- type
  result[["year"]] <- year
  result
}

#' Calculate irrecoverable carbon statistics
#'
#' Irrecoverable carbon is the amount of carbon that, if lost today, could not
#' be recovered until 2050. It can be calculated for above- and below-ground
#' carbon, the total amount of carbon, or for all layers.
#'
#' The required resources for this indicator are:
#'  - [irr_carbon]
#'
#' @name irr_carbon_stats
#' @param type One of "total", "soil", "biomass", "all". Determines
#'     for which data layer the statistics are calculated.
#' @param engine The preferred processing functions from either one of "zonal",
#'   "extract" or "exactextract" as character.
#' @param stats Function to be applied to compute statistics for polygons either
#'   one or multiple inputs as character. Supported statistics are: "mean",
#'   "median", "sd", "min", "max", "sum" "var".
#' @keywords indicator
#' @returns A function that returns a tibble with a column for each statistic
#'   and rows for every year and type of carbon.
#' @importFrom mapme.biodiversity check_engine check_stats
#' @export
calc_irr_carbon <- function(type = c("total", "soil", "biomass", "all"),
                            engine = "extract",
                            stats = "mean") {

  type <- match.arg(type)
  engine <- check_engine(engine)
  stats <- check_stats(stats)

  function(
    x,
    irr_carbon,
    name = "irr_carbon_stats",
    mode = "asset",
    verbose = mapme_options()[["verbose"]]) {

    .calc_carbon_stats(
      x,
      layer = irr_carbon,
      which_layer = type,
      stats = stats,
      engine = engine,
      name = "irr_carbon_stats",
      mode = "asset"
    )
  }
}

register_indicator(
  name = "irr_carbon_stats",
  description = "Statistics of irrecoverable carbon per polygon.",
  resources = "irr_carbon"
)

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
#' @name man_carbon_stats
#' @keywords indicator
#' @inherit irr_carbon_stats
#' @export
calc_man_carbon <- function(type = c("total", "soil", "biomass", "all"),
                            engine = "extract",
                            stats = "mean") {

  type <- match.arg(type)
  engine <- check_engine(engine)
  stats <- check_stats(stats)

  function(
    x,
    man_carbon,
    name = "man_carbon_stats",
    mode = "asset",
    verbose = mapme_options()[["verbose"]]) {

    .calc_carbon_stats(
      x,
      layer = man_carbon,
      which_layer = type,
      stats = stats,
      engine = engine,
      name = "man_carbon_stats",
      mode = "asset"
    )
  }
}

register_indicator(
  name = "man_carbon_stats",
  description = "Statistics of manageable carbon per polygon.",
  resources = "man_carbon"
)

#' Calculate vulnerable carbon statistics
#'
#' Vulnerable carbon is the amount of carbon that would be released in a typical
#' land conversion activity.
#' It can be calculated for above- and below-ground carbon, the total amount
#' of carbon, or for all layers.
#'
#' The required resources for this indicator are:
#'  - [vul_carbon]
#'
#' @name vul_carbon_stats
#' @keywords indicator
#' @inherit irr_carbon_stats
#' @export
calc_vul_carbon <- function(type = c("total", "soil", "biomass", "all"),
                            engine = "extract",
                            stats = "mean") {

  type <- match.arg(type)
  engine <- check_engine(engine)
  stats <- check_stats(stats)

  function(
    x,
    vul_carbon,
    name = "vul_carbon_stats",
    mode = "asset",
    verbose = mapme_options()[["verbose"]]) {

    .calc_carbon_stats(
      x,
      layer = vul_carbon,
      which_layer = type,
      stats = stats,
      engine = engine,
      name = "vul_carbon_stats",
      mode = "asset"
    )
  }
}

register_indicator(
  name = "vul_carbon_stats",
  description = "Statistics of vulnerable carbon per polygon.",
  resources = "vul_carbon"
)


#' @importFrom mapme.biodiversity select_engine
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

  result <- select_engine(
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

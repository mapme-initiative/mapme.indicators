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

#' @noRd
.calc_hfp <- function(
    x,
    humanfootprint,
    engine = "extract",
    stats_hfp = "mean",
    verbose = TRUE,
    ...) {

  if (is.null(humanfootprint)) {
    return(NA)
  }

  x <- st_transform(x, st_crs(humanfootprint))
  result <- mapme.biodiversity:::.select_engine(
    x = x,
    raster = humanfootprint,
    stats = stats_hfp,
    engine = engine,
    name = "humanfootprint",
    mode = "asset"
  )
  result[["year"]] <- substring(names(humanfootprint), 4, 7)
  result
}

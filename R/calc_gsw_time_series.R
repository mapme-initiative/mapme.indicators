#' Calculate Global Surface Water Time Series
#'
#' This function calculates the total area of the global surface water time
#' series data, separated by the following classes:
#'
#' - No Observation: It was not possible to determine whether a pixel was water
#' (this may be the case for frozen areas or during the polar night in extreme
#' latitudes).
#' - Permanent Water: Water was detected in twelve months per year or in a
#' combination of permanent and no observation.
#' - Seasonal Water: Water and no water was detected.
#' - No Water: No Water was detected.
#'
#' The required resources for this indicator are:
#'  - [gsw_time_series]
#'
#' @name gsw_time_series_yearly
#' @docType data
#' @keywords indicator
#' @format A tibble containing five columns; one for the year and one for each
#' GSW class ("No Observations", "Not Water", "Seasonal Water" and "Permanent
#' Water") in ha.
NULL

#' @noRd
#' @include zzz.R
.calc_gsw_time_series_yearly <- function(x,
                                  gsw_time_series,
                                  verbose = TRUE,
                                  ...) {
  if (base::is.null(gsw_time_series)) {
    return(NA)
  }

  gsw_time_series <- terra::mask(
    gsw_time_series,
    x
  )

  gsw_time_series <- terra::clamp(
    gsw_time_series,
    lower = 0,
    upper = 3,
    values = FALSE
  )

  pixel_areas <- terra::cellSize(
    gsw_time_series,
    mask = TRUE,
    unit = "ha"
  )

  ts_layer_ids <- seq_len(terra::nlyr(gsw_time_series))
  res_zonal <- lapply(ts_layer_ids, function(lyr_id, gsw_time_series,
                                             pixel_areas, layer_years) {
    gsw_ts_i <- terra::subset(gsw_time_series, lyr_id)
    res <- terra::zonal(
      pixel_areas,
      gsw_ts_i,
      fun = "sum"
    )
    names(res) <- c("gsw_class", "area")
    res_0 <- res$area [res$gsw_class == 0]
    res_1 <- res$area [res$gsw_class == 1]
    res_2 <- res$area [res$gsw_class == 2]
    res_3 <- res$area [res$gsw_class == 3]

    res <- data.frame(
      year = layer_years [lyr_id],
      gsw_no_observations_ha = ifelse(length(res_0) == 0, 0, res_0),
      gsw_not_water_ha = ifelse(length(res_1) == 0, 0, res_1),
      gsw_seasonal_water_ha = ifelse(length(res_2) == 0, 0, res_2),
      gsw_permanent_water_ha = ifelse(length(res_3) == 0, 0, res_3)
    )

    return(res)
  },
  gsw_time_series = gsw_time_series,
  pixel_areas = pixel_areas,
  layer_years = attributes(x)$years
  )
  results <- do.call(rbind, res_zonal)
  results <- tibble::tibble(results)

  return(results)
}

.register(list(
  name = "gsw_time_series_yearly",
  resources = list(gsw_time_series = "raster"),
  fun = .calc_gsw_time_series_yearly,
  arguments = list(),
  processing_mode = "asset"),
  "indicator"
)

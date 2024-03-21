test_that("calc_gsw_time_series works", {

  aoi <- st_transform(
      read_sf(system.file("shape/nc.shp", package="sf")),
      "EPSG:4326"
    )
  aoi <- suppressWarnings(st_cast(aoi, "POLYGON"))
  aoi <- aoi [5, ]

  outdir <- system.file("resources", package = "mapme.indicators")
  aoi <- init_portfolio(aoi, years = 2010:2011, outdir = outdir)
  aoi <- get_resources(aoi,
                       resources = "gsw_time_series",
                       vers_gsw_time_series = "LATEST"
                       )

  aoi <- calc_indicators(aoi, "gsw_time_series_yearly")

  indicator_colname <- "gsw_time_series_yearly"

  expect_true(indicator_colname %in% names(aoi))
  expect_equal(class(aoi[[indicator_colname]]), "list")
  expect_equal(names(aoi[[indicator_colname]][[1]]),
               c("year", "gsw_no_observations_ha", "gsw_not_water_ha",
                 "gsw_seasonal_water_ha", "gsw_permanent_water_ha"))

  expect_equal(aoi[[indicator_colname]][[1]][["year"]],
               c(2010, 2011))
  expect_equal(aoi[[indicator_colname]][[1]][["gsw_no_observations_ha"]],
               c(3427.065, 3427.376), tolerance = 1e-3)
  expect_equal(aoi[[indicator_colname]][[1]][["gsw_not_water_ha"]],
               c(66.9, 70.8), tolerance = 1e-3)
  expect_equal(aoi[[indicator_colname]][[1]][["gsw_seasonal_water_ha"]],
               c(344, 328), tolerance = 1e-3)
  expect_equal(aoi[[indicator_colname]][[1]][["gsw_permanent_water_ha"]],
               c(1346, 1358), tolerance = 1e-3)
})

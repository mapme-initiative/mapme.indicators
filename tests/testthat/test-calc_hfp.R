test_that("calc_hfp works", {

  aoi <- read_sf(system.file("shape/nc.shp", package="sf")) |>
    st_transform("EPSG:4326")
  aoi <- suppressWarnings(st_cast(aoi, "POLYGON"))

  outdir <- system.file("resources", package = "mapme.indicators")
  aoi <- init_portfolio(aoi, years = 2010:2015, outdir = outdir)
  expect_message(aoi <- get_resources(aoi, "humanfootprint"),
                 "Starting process to download resource 'humanfootprint'")

  aoi <- calc_indicators(aoi, "humanfootprint_stats", engine = "extract", stats_hfp = c("mean", "min", "max", "sd"))
  expect_true("humanfootprint_stats" %in% names(aoi))
  expect_equal(class(aoi[["humanfootprint_stats"]]), "list")
  expect_equal(names(aoi[["humanfootprint_stats"]][[1]]),
               c("humanfootprint_mean", "humanfootprint_min",
                 "humanfootprint_max", "humanfootprint_sd", "year"))
  expect_equal(aoi[["humanfootprint_stats"]][[1]][["year"]],
              c(2010:2015))

})

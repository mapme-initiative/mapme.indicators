test_that("calc_hfp works", {

  aoi <- read_sf(system.file("shape/nc.shp", package="sf")) |>
    st_transform("EPSG:4326")
  aoi <- suppressWarnings(st_cast(aoi, "POLYGON"))
  aoi <- aoi [5, ]

  outdir <- system.file("resources", package = "mapme.indicators")
  aoi <- init_portfolio(aoi, years = 2010:2015, outdir = outdir)
  aoi <- get_resources(aoi, "humanfootprint")

  aoi <- calc_indicators(aoi, "hfp", engine = "extract", stats_hfp = c("mean", "min", "max", "sd"))
  expect_true("hfp" %in% names(aoi))
  expect_equal(class(aoi[["hfp"]]), "list")
  expect_equal(names(aoi[["hfp"]][[1]]),
               c("humanfootprint_mean", "humanfootprint_min",
                 "humanfootprint_max", "humanfootprint_sd", "year"))
  expect_equal(aoi[["hfp"]][[1]][["year"]],
              c(2010:2015))

})

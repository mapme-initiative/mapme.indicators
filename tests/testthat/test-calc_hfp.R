test_that("calc_hfp works", {

  aoi <- read_sf(system.file("shape/nc.shp", package="sf")) %>%
    st_transform("EPSG:4326")
  aoi <- suppressWarnings(st_cast(aoi, "POLYGON"))
  aoi <- aoi [5, ]

  outdir <- system.file("resources", package = "mapme.indicators")
  mapme_options(outdir = outdir)
  aoi <- get_resources(aoi, get_humanfootprint(years = 2010:2015))
  aoi <- calc_indicators(aoi, calc_hfp(engine = "extract", stats = c("mean", "min", "max", "sd")))
  expect_true("hfp" %in% names(aoi))
  expect_equal(class(aoi[["hfp"]]), "list")
  expect_equal(names(aoi[["hfp"]][[1]]),
               c("hfp_mean", "hfp_min",
                 "hfp_max", "hfp_sd", "year"))
  expect_equal(aoi[["hfp"]][[1]][["year"]],
              c(2010:2015))

})

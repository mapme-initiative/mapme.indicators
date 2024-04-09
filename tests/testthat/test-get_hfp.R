test_that("get_hfp works", {
  skip_on_cran()
  aoi <- read_sf(system.file("shape/nc.shp", package="sf")) %>%
    st_transform("EPSG:4326")
  aoi <- suppressWarnings(st_cast(aoi, "POLYGON"))

  outdir <- system.file("resources", package = "mapme.indicators")
  mapme_options(outdir = outdir, testing = TRUE)
  ghfp <- get_humanfootprint(years = 2010:2015)
  filenames <- ghfp(aoi)
  expect_equal(basename(filenames), paste0("hfp", 2010:2015, ".zip"))
})

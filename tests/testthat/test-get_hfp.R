test_that("get_hfp works", {
  skip_on_cran()
  aoi <- st_transform(
      read_sf(system.file("shape/nc.shp", package="sf")),
      "EPSG:4326"
    )
  aoi <- suppressWarnings(st_cast(aoi, "POLYGON"))

  outdir <- system.file("resources", package = "mapme.indicators")
  aoi <- init_portfolio(aoi, years = 2010:2015, outdir = outdir)
  attributes(aoi)[["testing"]] <- TRUE
  filenames <- .get_hfp(aoi, rundir = file.path(outdir, "humanfootprint"), verbose = TRUE)
  expect_equal(basename(filenames), paste0("hfp", 2010:2015, ".zip"))
})

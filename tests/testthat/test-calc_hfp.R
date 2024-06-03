test_that("calc_hfp works", {
  x <- read_sf(system.file("shape/nc.shp", package="sf"))
  x <- x [5, ]
  x <- st_transform(x, "EPSG:4326")

  outdir <- system.file("resources", package = "mapme.indicators")
  mapme_options(outdir = outdir, testing = TRUE, verbose = FALSE)
  x <- get_resources(x, get_humanfootprint(years = 2010:2015))
  x <- calc_indicators(x,
                       calc_humanfootprint(
                         engine = "extract",
                         stats = c("min", "max", "sd"))
  )
  expect_true("humanfootprint" %in% names(x))
  expect_equal(class(x[["humanfootprint"]]), "list")
  variables <- unique(x[["humanfootprint"]][[1]][["variable"]])
  expect_equal(variables, c("humanfootprint_max",
                            "humanfootprint_min",
                            "humanfootprint_sd"))
  expect_snapshot(x[["humanfootprint"]][[1]][["value"]])
})

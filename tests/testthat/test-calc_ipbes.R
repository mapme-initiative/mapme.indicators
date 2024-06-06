test_that("calc_ipbes_biomes works", {
  x <- read_sf(system.file("shape/nc.shp", package="sf"))
  x <- x [5, ]
  x <- st_transform(x, "EPSG:4326")
  outdir <- system.file("resources", package = "mapme.indicators")
  mapme_options(outdir = outdir, verbose = FALSE)
  get_resources(x, get_ipbes_biomes())
  ind <- calc_indicators(x, calc_ipbes_biomes())
  expect_true("ipbes_biomes" %in% names(ind))
  expect_equal(class(ind[["ipbes_biomes"]]), "list")
})


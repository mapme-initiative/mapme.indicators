test_that("calc_ipbes_biomes works", {

  aoi <- read_sf(system.file("shape/nc.shp", package="sf")) %>%
    st_transform("EPSG:4326")
  aoi <- suppressWarnings(st_cast(aoi, "POLYGON"))
  aoi <- aoi [5, ]
  outdir <- system.file("resources", package = "mapme.indicators")
  aoi <- init_portfolio(aoi, years = 2010:2015, outdir = outdir)
  aoi <- get_resources(aoi, "ipbes_biome")

  aoi <- calc_indicators(aoi, "ipbes_biome_stats")
  expect_true("ipbes_biome_stats" %in% names(aoi))
  expect_equal(class(aoi[["ipbes_biome_stats"]]), "list")
  expect_equal(names(aoi[["ipbes_biome_stats"]][[1]]),
               c("class", "area", "percentage"))
})


test_that("calc_ipbes_anthrome works", {

  aoi <- read_sf(system.file("shape/nc.shp", package="sf")) %>%
    st_transform("EPSG:4326")
  aoi <- suppressWarnings(st_cast(aoi, "POLYGON"))
  aoi <- aoi [5, ]

  outdir <- system.file("resources", package = "mapme.indicators")
  aoi <- init_portfolio(aoi, years = 2010:2015, outdir = outdir)
  aoi <- get_resources(aoi, "ipbes_anthrome")

  aoi <- calc_indicators(aoi, "ipbes_anthrome_stats", anthrome = "both")
  expect_true("ipbes_anthrome_stats" %in% names(aoi))
  expect_equal(class(aoi[["ipbes_anthrome_stats"]]), "list")
  expect_equal(names(aoi[["ipbes_anthrome_stats"]][[1]]),
               c("anthrome", "affected", "percentage", "total"))
  expect_equal(aoi[["ipbes_anthrome_stats"]][[1]][["anthrome"]],
               c("urban_areas", "cultivated_areas"))
})


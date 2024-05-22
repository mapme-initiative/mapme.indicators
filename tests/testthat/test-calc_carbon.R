test_that("calc_irr_carbon works", {
  x <- read_sf(system.file("shape/nc.shp", package="sf"))
  x <- x [5, ]
  x <- st_transform(x, "EPSG:4326")

  outdir <- system.file("resources", package = "mapme.indicators")
  mapme_options(outdir = outdir)
  x <- get_resources(x, get_irr_carbon())
  x <- calc_indicators(
    x,
    calc_irr_carbon(
      type = "biomass",
      stats = c("mean", "min"),
      engine = "extract")
  )

  expect_true("irr_carbon" %in% names(x))
  expect_equal(class(x[["irr_carbon"]]), "list")
  vars <- c("irr_carbon_biomass_mean", "irr_carbon_biomass_min")
  expect_equal(unique(x[["irr_carbon"]][[1]][["variable"]]), vars)
  expect_snapshot(x[["irr_carbon"]][[1]][["value"]])
})


test_that("calc_vul_carbon works", {
  x <- read_sf(system.file("shape/nc.shp", package="sf"))
  x <- x [5, ]
  x <- st_transform(x, "EPSG:4326")

  outdir <- system.file("resources", package = "mapme.indicators")
  mapme_options(outdir = outdir)
  x <- get_resources(x, get_vul_carbon())
  x <- calc_indicators(
    x,
    calc_vul_carbon(
      type = "total",
      stats = c("min", "mean"),
      engine = "extract")
  )

  expect_true("vul_carbon" %in% names(x))
  expect_equal(class(x[["vul_carbon"]]), "list")
  vars <- c("vul_carbon_total_mean", "vul_carbon_total_min")
  expect_equal(unique(x[["vul_carbon"]][[1]][["variable"]]), vars)
  expect_snapshot(x[["vul_carbon"]][[1]][["value"]])
})

test_that("calc_man_carbon works", {
  x <- read_sf(system.file("shape/nc.shp", package="sf"))
  x <- x [5, ]
  x <- st_transform(x, "EPSG:4326")

  outdir <- system.file("resources", package = "mapme.indicators")
  mapme_options(outdir = outdir)
  x <- get_resources(x, get_man_carbon())
  x <- calc_indicators(
    x,
    calc_man_carbon(
      type = "soil",
      stats = c("max", "sd"),
      engine = "extract")
  )

  expect_true("man_carbon" %in% names(x))
  expect_equal(class(x[["man_carbon"]]), "list")
  vars <- c("man_carbon_soil_max", "man_carbon_soil_sd")
  expect_equal(unique(x[["man_carbon"]][[1]][["variable"]]), vars)
  expect_snapshot(x[["man_carbon"]][[1]][["value"]])
})

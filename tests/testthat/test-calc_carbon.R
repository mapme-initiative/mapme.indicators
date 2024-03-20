test_that("calc_irr_carbon works", {

  aoi <- read_sf(system.file("shape/nc.shp", package="sf")) |>
    st_transform("EPSG:4326")
  aoi <- suppressWarnings(st_cast(aoi, "POLYGON"))
  aoi <- aoi [5, ]

  outdir <- system.file("resources", package = "mapme.indicators")
  aoi <- init_portfolio(aoi, years = 2010:2015, outdir = outdir)
  aoi <- get_resources(aoi, "irr_carbon")

  aoi <- calc_indicators(aoi, "irr_carbon_stats", which_carbon = "all", stats_carbon = c("mean", "min", "max", "sd"), engine = "extract")
  expect_true("irr_carbon_stats" %in% names(aoi))
  expect_equal(class(aoi[["irr_carbon_stats"]]), "list")
  expect_equal(names(aoi[["irr_carbon_stats"]][[1]]),
               c("irr_carbon_mean", "irr_carbon_min",
                 "irr_carbon_max", "irr_carbon_sd",
                 "type", "year"))

  expect_equal(aoi[["irr_carbon_stats"]][[1]][["type"]],
               rep(c("biomass", "soil", "total"), each = 2))

  expect_equal(aoi[["irr_carbon_stats"]][[1]][["year"]],
               rep(c(2010, 2018), 3))

})


test_that("calc_vul_carbon works", {

  aoi <- read_sf(system.file("shape/nc.shp", package="sf")) |>
    st_transform("EPSG:4326")
  aoi <- suppressWarnings(st_cast(aoi, "POLYGON"))
  aoi <- aoi [5, ]

  outdir <- system.file("resources", package = "mapme.indicators")
  aoi <- init_portfolio(aoi, years = 2010:2015, outdir = outdir)
  aoi <- get_resources(aoi, "vul_carbon")

  aoi <- calc_indicators(aoi, "vul_carbon_stats", which_carbon = "all", stats_carbon = c("mean", "min", "max", "sd"), engine = "extract")
  expect_true("vul_carbon_stats" %in% names(aoi))
  expect_equal(class(aoi[["vul_carbon_stats"]]), "list")
  expect_equal(names(aoi[["vul_carbon_stats"]][[1]]),
               c("vul_carbon_mean", "vul_carbon_min",
                 "vul_carbon_max", "vul_carbon_sd",
                 "type", "year"))

  expect_equal(aoi[["vul_carbon_stats"]][[1]][["type"]],
               rep(c("biomass", "soil", "total"), each = 2))

  expect_equal(aoi[["vul_carbon_stats"]][[1]][["year"]],
               rep(c(2010, 2018), 3))

})

test_that("calc_man_carbon works", {

  aoi <- read_sf(system.file("shape/nc.shp", package="sf")) |>
    st_transform("EPSG:4326")
  aoi <- suppressWarnings(st_cast(aoi, "POLYGON"))

  outdir <- system.file("resources", package = "mapme.indicators")
  aoi <- init_portfolio(aoi, years = 2010:2015, outdir = outdir)
  aoi <- get_resources(aoi, "man_carbon")
  aoi <- aoi [5, ]

  aoi <- calc_indicators(aoi, "man_carbon_stats", which_carbon = "all", stats_carbon = c("mean", "min", "max", "sd"), engine = "extract")
  expect_true("man_carbon_stats" %in% names(aoi))
  expect_equal(class(aoi[["man_carbon_stats"]]), "list")
  expect_equal(names(aoi[["man_carbon_stats"]][[1]]),
               c("man_carbon_mean", "man_carbon_min",
                 "man_carbon_max", "man_carbon_sd",
                 "type", "year"))

  expect_equal(aoi[["man_carbon_stats"]][[1]][["type"]],
               rep(c("biomass", "soil", "total"), each = 2))

  expect_equal(aoi[["man_carbon_stats"]][[1]][["year"]],
               rep(c(2010, 2018), 3))

})

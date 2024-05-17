test_that(".get_gsw_time_series_tile_id works", {
  gsw_grid <- make_global_grid()
  expect_equal(.get_gsw_ts_tile_id(gfw_grid[100, ]), "0000400000-0001160000")
})

test_that(".get_gsw_time_series works", {
  skip_on_cran()

  x <- read_sf(
    system.file("extdata", "sierra_de_neiba_478140.gpkg",
                package = "mapme.biodiversity"
    )
  )
  expect_error(get_gsw_time_series("na"))
  gsw <- get_gsw_time_series(years = 2000)
  expect_silent(mapme.biodiversity:::.check_resource_fun(gsw))
  expect_silent(fps <- gsw(x))
  expect_silent(mapme.biodiversity:::.check_footprints(fps))
  expect_equal(fps$filename, "yearlyClassification2000-0000240000-0000400000.tif")
})

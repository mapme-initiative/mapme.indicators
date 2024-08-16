test_that("gsw time series works", {
  x <- read_sf(system.file("extdata", "shell_beach_protected_area_41057_B.gpkg",
                           package = "mapme.biodiversity"))
  .clear_resources()
  outdir <- file.path(tempdir(), "mapme.data")
  .copy_resource_dir(outdir)
  mapme_options(outdir = outdir, verbose = FALSE)

  get_resources(x, get_gsw_time_series(years=c(2000,2001), version = "VER5-0"))
  gswts <- prep_resources(x)[["gsw_time_series"]]
  gsw <- calc_gsw_time_series(years=2000:2001)

  expect_silent(result <- gsw(x, gswts))
  expect_silent(.check_single_asset(result))
  expect_equal(nrow(result), 8)
  vars <- c("no_observations", "not_water", "seasonal_water", "permanent_water")
  expect_equal(unique(result$variable), vars)
  vals <- c(2684.78, 2635.355, 13.99, 0.00, 337.11, 327.85, 129.96, 202.64)
  expect_equal(result$value, vals, tolerance = 0.01)
})

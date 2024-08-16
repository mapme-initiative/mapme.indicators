test_that("calc_ipbes_biomes works", {
  skip_on_cran()
  x <- read_sf(system.file("extdata", "shell_beach_protected_area_41057_B.gpkg",
                           package = "mapme.biodiversity"))
  .clear_resources()
  outdir <- file.path(tempdir(), "mapme.data")
  .copy_resource_dir(outdir)
  mapme_options(outdir = outdir, verbose = FALSE)

  get_resources(x, get_ipbes_biomes())
  ipbes <- prep_resources(x)[["ipbes_biomes"]]
  ib <- calc_ipbes_biomes()

  result <- ib(x, ipbes)
  expect_true(inherits(result, "list"))
  result <- result[[1]]
  expect_silent(.check_single_asset(result))
  expect_equal(result$value, c(1184.2016, 1988.4815), tolerance = 0.01)
})


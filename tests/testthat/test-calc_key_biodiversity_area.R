test_that("key biodiversity area works", {
  x <- read_sf(system.file("extdata", "shell_beach_protected_area_41057_B.gpkg",
                package = "mapme.biodiversity"))
  .clear_resources()
  outdir <- tempfile()
  dir.create(outdir)
  mapme_options(outdir = outdir, verbose = FALSE)
  kbas <- system.file("resources", "key_biodiversity_areas", "kbas.gpkg",
                      package = "mapme.indicators")
  get_resources(x, get_key_biodiversity_areas(path = kbas))
  kbas <- prep_resources(x)[["key_biodiversity_areas"]]

  kb <- calc_key_biodiversity_area()
  result <- kb(x, kbas)
  expect_silent(.check_single_asset(result))
  expect_equal(result$value, 101.2097, tolerance = 0.01)
  # check NULL is returned for 0-length tibbles
  st_geometry(x) <- st_geometry(x) + 5
  st_crs(x) <- st_crs(4326)
  expect_equal(kb(x, kbas), NULL)
})

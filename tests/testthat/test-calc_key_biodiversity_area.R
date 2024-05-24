test_that("key biodiversity area works", {
  aoi <- read_sf(
    system.file("extdata", "shell_beach_protected_area_41057_B.gpkg",
                package = "mapme.biodiversity"
    )
  )

  outdir <- system.file("resources", package = "mapme.indicators")
  mapme_options(outdir = outdir, verbose = FALSE)

  fname_kbas <- system.file("resources/key_biodiversity_areas/kbas.gpkg", package = "mapme.indicators")
  aoi <- aoi %>%
    get_resources(get_key_biodiversity_areas(fname_kbas))

  res <- aoi %>%
    calc_indicators(
      calc_key_biodiversity_area()
    )

  res <- res$key_biodiversity_areas [[1]]

  expect_equal(
    res$datetime,
    "2024-01-01"
  )

  expect_equal(
    res$variable,
    "Key biodiversity area"
  )

  expect_equal(
    res$unit,
    "ha"
  )

  expect_equal(
    res$value,
    101.2097,
    tolerance = 0.01
  )
})

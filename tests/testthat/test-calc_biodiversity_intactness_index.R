test_that("biodiversity intactness index works", {
  aoi <- read_sf(
    system.file("extdata", "shell_beach_protected_area_41057_B.gpkg",
                package = "mapme.biodiversity"
    )
  )

  outdir <- system.file("resources", package = "mapme.indicators")
  mapme_options(outdir = outdir, verbose = FALSE)

  fname_bii <- system.file("resources/biodiversity_intactness_index/bii.tif", package = "mapme.indicators")
  aoi <- aoi %>%
    get_resources(get_biodiversity_intactness_index(fname_bii))

  res <- aoi %>%
    calc_indicators(
      calc_biodiversity_intactness_index()
    )

  res <- res$biodiversity_intactness_index [[1]]

  expect_equal(
    res$datetime,
    "2016-01-01"
  )

  expect_equal(
    res$variable,
    "Biodiversity intactness index (mean)"
  )

  expect_equal(
    res$unit,
    NA
  )

  expect_equal(
    res$value,
    0.917,
    tolerance = 0.01
  )
})

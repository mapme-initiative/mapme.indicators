test_that("biodiversity intactness index works", {
  fname_aoi <- system.file("extdata", "shell_beach_protected_area_41057_B.gpkg",
                           package = "mapme.biodiversity"
    )
  aoi <- read_sf(fname_aoi)

  outdir <- system.file("resources", package = "mapme.indicators")
  mapme_options(outdir = NULL, verbose = FALSE)

  expect_error(get_biodiversity_intactness_index(),
               "Expecting path to point towards an existing file.")
  expect_error(get_biodiversity_intactness_index(fname_aoi),
               "Unexpected file extension: path must point towards a '.asc' file.")


  fname_bii <- system.file("resources/biodiversity_intactness_index/lbii.asc",
                           package = "mapme.indicators"
    )
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
    "unitless"
  )

  expect_equal(
    res$value,
    0.917,
    tolerance = 0.01
  )
})

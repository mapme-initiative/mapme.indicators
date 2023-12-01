devtools::load_all()
library(progressr)
library(future)

aoi <- st_read(system.file("shape/nc.shp", package="sf")) |>
  st_transform("EPSG:4326") |>
  st_cast("POLYGON")

port <- init_portfolio(aoi, years = 2010:2015, outdir = "data-raw/", add_resources = FALSE)


port <- get_resources(port, "humanfootprint")

plan(multisession, workers = 8)
timing <- system.time(with_progress({
hfp <- calc_indicators(port, "humanfootprint", engine = "extract", stats_hfp = c("mean", "sd", "max", "min"))
}))
plan(sequential)

hfp$humanfootprint


port <- get_resources(port, c("ipbes_biome", "ipbes_anthrome"))

plan(multisession, workers = 8)
timing <- system.time(with_progress({
  biomes <- calc_indicators(port, "ipbes_biome")
}))
plan(sequential)

biomes$ipbes_biome

plan(multisession, workers = 8)
timing <- system.time(with_progress({
  anthromes <- calc_indicators(port, "ipbes_anthrome")
}))
plan(sequential)
anthromes$ipbes_anthrome

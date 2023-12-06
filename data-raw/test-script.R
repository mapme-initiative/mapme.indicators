library(LLFindicators)
library(sf)
library(progressr)
library(future)

names(available_resources())
names(available_indicators())

aoi <- st_read(system.file("shape/nc.shp", package="sf")) |>
  st_transform("EPSG:4326") |>
  st_cast("POLYGON")

port <- init_portfolio(aoi, years = 2010:2015, outdir = "../data")

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


port <- get_resources(port, c("irr_carbon", "vul_carbon", "man_carbon"))

plan(multisession, workers = 8)
timing <- system.time(with_progress({
  irr_carbon <- calc_indicators(port, "irr_carbon",
                                engine = "exactextract",
                                which_carbon = "all",
                                stats_carbon = c("sum"))
}))
plan(sequential)
irr_carbon$irr_carbon


plan(multisession, workers = 8)
timing <- system.time(with_progress({
  man_carbon <- calc_indicators(port, "man_carbon",
                                engine = "exactextract",
                                which_carbon = "all",
                                stats_carbon = c("sum"))
}))
plan(sequential)
man_carbon$man_carbon

plan(multisession, workers = 8)
timing <- system.time(with_progress({
  vul_carbon <- calc_indicators(port, "vul_carbon",
                                engine = "exactextract",
                                which_carbon = "all",
                                stats_carbon = c("sum"))
}))
plan(sequential)
vul_carbon$vul_carbon




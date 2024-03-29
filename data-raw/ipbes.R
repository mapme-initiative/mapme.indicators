library(LLFindicators)
library(terra)
library(sf)

aoi <- st_read(system.file("shape/nc.shp", package="sf")) %>%
  st_transform("EPSG:4326") %>%
  st_cast("POLYGON") %>%
  init_portfolio(years = c(2000:2020), outdir = "../data/") %>%
  get_resources(c("ipbes_anthrome", "ipbes_biome"))

tindex_biome <- st_read(attr(aoi, "resources")["ipbes_biome"])
biome <- rast(tindex_biome[["location"]])
biome <- crop(biome, aoi)

outdir <- "inst/ipbes_biome"
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
writeRaster(biome, file.path(outdir, basename(tindex_biome[["location"]])))

tindex_anthrome <- st_read(attr(aoi, "resources")["ipbes_anthrome"])
anthrome <- rast(tindex_anthrome[["location"]])
anthrome <- crop(anthrome, aoi)

outdir <- "inst/ipbes_anthrome"
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
writeRaster(anthrome, file.path(outdir, basename(tindex_anthrome[["location"]])))


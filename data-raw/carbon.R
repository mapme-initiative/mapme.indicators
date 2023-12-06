library(LLFindicators)
library(terra)
library(sf)

aoi <- st_read(system.file("shape/nc.shp", package="sf")) |>
  st_transform("EPSG:4326") |>
  st_cast("POLYGON") |>
  init_portfolio(years = c(2000:2020), outdir = "../data/") |>
  get_resources(c("irr_carbon", "vul_carbon", "man_carbon"))

tindex_irr <- attr(aoi, "resources")[["irr_carbon"]]
irr_carbon <- rast(tindex_irr[["location"]])
irr_carbon <- crop(irr_carbon, aoi)

outdir <- "inst/resources/irr_carbon"
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
writeRaster(irr_carbon, file.path(outdir, basename(tindex_irr[["location"]])))
file.create(file.path(outdir, paste0("Irrecoverable_Carbon_", c(2010, 2018), ".zip")))

tindex_vul <- attr(aoi, "resources")[["vul_carbon"]]
vul_carbon <- rast(tindex_vul[["location"]])
vul_carbon <- crop(vul_carbon, aoi)

outdir <- "inst/resources/vul_carbon"
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
writeRaster(vul_carbon, file.path(outdir, basename(tindex_vul[["location"]])))
file.create(file.path(outdir, paste0("Vulnerable_Carbon_", c(2010, 2018), ".zip")))

tindex_man <- attr(aoi, "resources")[["man_carbon"]]
man_carbon <- rast(tindex_man[["location"]])
man_carbon <- crop(man_carbon, aoi)

outdir <- "inst/resources/man_carbon"
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
writeRaster(man_carbon, file.path(outdir, basename(tindex_man[["location"]])))
file.create(file.path(outdir, paste0("Manageable_Carbon_", c(2010, 2018), ".zip")))


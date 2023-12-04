library(LLFindicators)
library(terra)
library(sf)

aoi <- st_read(system.file("shape/nc.shp", package="sf")) |>
  st_transform("EPSG:4326") |>
  st_cast("POLYGON") |>
  init_portfolio(years = c(2000:2020), outdir = "../data/", add_resources = FALSE) |>
  get_resources(c("irr_carbon", "vul_carbon", "man_carbon"))

tindex_irr <- attr(aoi, "resources")["irr_carbon"] |> st_read()
irr_carbon <- rast(tindex_irr[["location"]])
irr_carbon <- crop(irr_carbon, aoi)

outdir <- "inst/irr_carbon"
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
writeRaster(irr_carbon, file.path(outdir, basename(tindex_irr[["location"]])))

tindex_vul <- attr(aoi, "resources")["vul_carbon"] |> st_read()
vul_carbon <- rast(tindex_vul[["location"]])
vul_carbon <- crop(vul_carbon, aoi)

outdir <- "inst/vul_carbon"
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
writeRaster(vul_carbon, file.path(outdir, basename(tindex_vul[["location"]])))

tindex_man <- attr(aoi, "resources")["man_carbon"] |> st_read()
man_carbon <- rast(tindex_man[["location"]])
man_carbon <- crop(man_carbon, aoi)

outdir <- "inst/man_carbon"
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
writeRaster(man_carbon, file.path(outdir, basename(tindex_vul[["location"]])))


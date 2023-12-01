library(LLFindicators)
library(terra)
library(sf)

aoi <- st_read(system.file("shape/nc.shp", package="sf")) |>
  st_transform("EPSG:4326") |>
  st_cast("POLYGON") |>
  init_portfolio(years = c(2000:2020), outdir = "./data-raw/") |>
  get_resources("humanfootprint")

tindex <- attr(aoi, "resources")["humanfootprint"] |> st_read()
hfp <- rast(tindex[["location"]])
hfp <- crop(hfp, st_transform(aoi, crs(hfp)))

outdir <- "inst/humanfootprint"
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
writeRaster(hfp, file.path(outdir, paste0(names(hfp), ".tif")))
file.create(file.path(outdir, paste0(names(hfp), ".zip")))


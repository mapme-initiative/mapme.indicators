library(sf)

aoi <- st_read(system.file("shape/nc.shp", package="sf"))
aoi <- st_transform(aoi, "EPSG:4326")
aoi <- st_cast(aoi, "POLYGON")
aoi <- aoi [5, ]
aoi <- init_portfolio(aoi, years = c(2010:2011), outdir = "../data")
aoi <- get_resources(aoi, "gsw_time_series")

tiles <- attr(aoi, "resources")[["gsw_time_series"]][["location"]]
for (tile_uri in tiles) {
  tile <- terra::rast(tile_uri)
  tile <- terra::crop(tile, aoi)
  tile <- terra::mask(tile, aoi)
  dirname_out <- "inst/resources/gsw_time_series/"
  dir.create(dirname_out, showWarnings = FALSE)
  fname_out <- paste0(dirname_out, basename(tile_uri))
  terra::writeRaster(tile, fname_out)
}

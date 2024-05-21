library(mapme.indicators)
library(terra)
library(sf)

x <- st_read(system.file("shape/nc.shp", package="sf"))
x <- x[5, ]
x <- st_transform(x, "EPSG:4326")

outdir <- tempfile()
dir.create(outdir)
mapme_options(outdir = outdir)

get_resources(x, get_humanfootprint(years=2010:2015))
hfp <- prep_resources(x)$humanfootprint
writeRaster(hfp,
            filename = file.path("inst/resources/humanfootprint/", paste0(names(hfp), ".tif")),
            datatype = "FLT4S", gdal = c("COMPRESS=LZW"),
            overwrite = TRUE)
zips <- paste0(names(hfp), ".zip")
file.create(file.path("inst/resources/humanfootprint/", zips))

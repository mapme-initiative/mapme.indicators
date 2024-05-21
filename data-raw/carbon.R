library(mapme.indicators)
library(terra)
library(sf)

x <- st_read(system.file("shape/nc.shp", package="sf"))
x <- x[5, ]
x <- st_transform(x, "EPSG:4326")

outdir <- tempfile()
dir.create(outdir)
mapme_options(outdir = outdir)

options(timeout = 600)
get_resources(x, get_irr_carbon(), get_vul_carbon(), get_man_carbon())
resources <- prep_resources(x)
tindex <- mapme.biodiversity:::.avail_resources()

outdir <- "inst/resources/irr_carbon"
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
irr_carbon <- resources$irr_carbon
writeRaster(resources$irr_carbon,
            file.path(outdir, basename(tindex$irr_carbon$location)),
            datatype = "INT2U", overwrite = TRUE,
            wopt = list(gdal=c("COMPRESS=LZW")))

outdir <- "inst/resources/vul_carbon"
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
writeRaster(resources$vul_carbon,
            file.path(outdir, basename(tindex$vul_carbon$location)),
            datatype = "INT2U", overwrite = TRUE,
            wopt = list(gdal=c("COMPRESS=LZW")))

outdir <- "inst/resources/man_carbon"
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
writeRaster(resources$man_carbon,
            file.path(outdir, basename(tindex$man_carbon$location)),
            datatype = "INT2U", overwrite = TRUE,
            wopt = list(gdal=c("COMPRESS=LZW")))

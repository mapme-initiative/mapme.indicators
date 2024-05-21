library(mapme.indicators)
library(terra)
library(sf)

x <- st_read(system.file("shape/nc.shp", package="sf"))
x <- x[5, ]
x <- st_transform(x, "EPSG:4326")

outdir <- tempfile()
dir.create(outdir)
mapme_options(outdir = outdir)

get_resources(x, get_ipbes_biomes())
biome <- prep_resources(x)$ipbes_biomes

writeRaster(biome,
            filename = file.path("inst/resources/ipbes_biomes/", paste0(names(biome), ".tif")),
            datatype = "INT1U", gdal = c("COMPRESS=LZW"),
            overwrite = TRUE)

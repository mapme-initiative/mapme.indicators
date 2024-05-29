library(mapme.indicators)
library(terra)

outdir <- system.file("resources", package = "mapme.indicators")
mapme_options(outdir = outdir)

x <- read_sf(
  system.file("extdata", "shell_beach_protected_area_41057_B.gpkg",
              package = "mapme.biodiversity"
  )
) %>%
get_resources(get_biodiversity_intactness_index("bii.tif"))

bii <- prep_resources(x)
bii <- bii [[1]]

outdir <- "inst/resources/biodiversity_intactness_index"
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)

bii <- mask(bii, x)
writeRaster(bii, file.path(outdir, "bii.tif"))

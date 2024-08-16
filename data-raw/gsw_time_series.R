library(mapme.biodiversity)
library(terra)
library(sf)

years <- 2000:2001
outdir <- tempfile()
dir.create(outdir)
mapme_options(outdir = outdir)

x <- read_sf(
  system.file("extdata", "shell_beach_protected_area_41057_B.gpkg",
              package = "mapme.biodiversity")) %>%
  get_resources(get_gsw_time_series(years = years))

gsw_time_series <- prep_resources(x)
gsw_time_series <- gsw_time_series [[1]]

outdir <- "inst/resources/gsw_time_series"
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)

gsw_time_series <- mask(gsw_time_series, x)
tindex <- mapme.biodiversity:::.avail_resources()[["gsw_time_series"]]
writeRaster(gsw_time_series, filename =  file.path(outdir, tindex$filename),
            datatype = "INT1U", wopt = list(gdal=c("COMPRESS=LZW")))

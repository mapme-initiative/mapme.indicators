library(mapme.biodiversity)
library(sf)

x <- read_sf(
  system.file("extdata", "shell_beach_protected_area_41057_B.gpkg",
              package = "mapme.biodiversity"
  )
) %>%
get_resources(get_key_biodiversity_areas("kbas.gpkg"))

kbas <- prep_resources(x)[[1]][[1]]
kbas <- st_make_valid(kbas)

outdir <- "inst/resources/key_biodiversity_areas"
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)

kbas_sub <- st_intersection(kbas, x)[ ,names(kbas)]
st_write(kbas_sub, file.path(outdir, "kbas.gpkg"))


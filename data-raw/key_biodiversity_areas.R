library(dplyr)
library(magrittr)
library(mapme.indicators)
library(sf)

outdir <- system.file("resources", package = "mapme.indicators")
mapme_options(outdir = outdir)

x <- read_sf(
  system.file("extdata", "shell_beach_protected_area_41057_B.gpkg",
              package = "mapme.biodiversity"
  )
) %>%
get_resources(get_key_biodiversity_areas("kbas.gpkg"))

kbas <- prep_resources(x) %>%
  extract2(1)

outdir <- "inst/resources/key_biodiversity_areas"
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)

sf_use_s2(FALSE)
kbas_sub <- st_intersection(kbas [[1]], x) %>%
  mutate(id = 1) %>%
  select(id)

write_sf(kbas_sub, file.path(outdir, "kbas.gpkg"))


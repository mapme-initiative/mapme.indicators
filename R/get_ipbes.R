#' Terrestrial and Aquatic Biomes
#'
#' This resource is part of the Global Assessment Report on Biodiversity and
#' Ecosystem Services.
#'
#' @name ipbes_biome
#' @docType data
#' @keywords resource
#' @format A global tiled raster resource available for all land and ocean areas.
#' @references IPBES (2019): Summary for policymakers of the global assessment
#' report on biodiversity and ecosystem services of the Intergovernmental
#' Science-Policy Platform on Biodiversity and Ecosystem Services. S. Díaz, J.
#' Settele, E. S. Brondízio, H. T. Ngo, M. Guèze, J. Agard, A. Arneth, P.
#' Balvanera, K. A. Brauman, S. H. M. Butchart, K. M. A. Chan, L. A. Garibaldi,
#' K. Ichii, J. Liu, S. M. Subramanian, G. F. Midgley, P. Miloslavich, Z.
#' Molnár, D. Obura, A. Pfaff, S. Polasky, A. Purvis, J. Razzaque, B. Reyers, R.
#'  Roy Chowdhury, Y. J. Shin, I. J. Visseren-Hamakers, K. J. Willis, and C. N.
#'  Zayas (eds.). IPBES secretariat, Bonn, Germany. 56 pages.
#'  https://doi.org/10.5281/zenodo.3553579
#' @source \url{https://zenodo.org/records/3975694}
NULL

#' @include zzz.R
.get_ipbes_biome <- function(x,
                             rundir = tempdir(),
                             verbose = TRUE,
                             ...) {

  biome_url <- "/vsicurl/https://zenodo.org/records/3975694/files/IPBES_UoA_biomes_JK.tif"
  filename <- file.path(rundir, basename(biome_url))
  if(file.exists(filename)) return(filename)
  biome <- rast(biome_url)
  levels(biome) <- ipbes_biome_classes
  writeRaster(biome, filename)
  filename
}

.register(list(
  name = "ipbes_biome",
  type = "raster",
  source = "https://zenodo.org/records/3975694",
  fun = .get_ipbes_biome,
  arguments = list()),
  "resource")

#' Terrestrial Anthromes
#'
#' This resource is part of the Global Assessment Report on Biodiversity and
#' Ecosystem Services.
#'
#' @name ipbes_anthrome
#' @docType data
#' @keywords resource
#' @format A global tiled raster resource available for all land areas.
#' @references IPBES (2019): Summary for policymakers of the global assessment
#' report on biodiversity and ecosystem services of the Intergovernmental
#' Science-Policy Platform on Biodiversity and Ecosystem Services. S. Díaz, J.
#' Settele, E. S. Brondízio, H. T. Ngo, M. Guèze, J. Agard, A. Arneth, P.
#' Balvanera, K. A. Brauman, S. H. M. Butchart, K. M. A. Chan, L. A. Garibaldi,
#' K. Ichii, J. Liu, S. M. Subramanian, G. F. Midgley, P. Miloslavich, Z.
#' Molnár, D. Obura, A. Pfaff, S. Polasky, A. Purvis, J. Razzaque, B. Reyers, R.
#'  Roy Chowdhury, Y. J. Shin, I. J. Visseren-Hamakers, K. J. Willis, and C. N.
#'  Zayas (eds.). IPBES secretariat, Bonn, Germany. 56 pages.
#'  https://doi.org/10.5281/zenodo.3553579
#' @source \url{https://zenodo.org/records/3975694}
NULL

#' @include zzz.R
.get_ipbes_anthrome <- function(x,
                                rundir = tempdir(),
                                verbose = TRUE,
                                ...) {

  anthrome_url <- "/vsicurl/https://zenodo.org/records/3975694/files/IPBES_UoA_anthrome.tif"
  filenames <- file.path(rundir, paste0(c("urban_areas", "cultivated_areas"), "_", basename(anthrome_url)))
  if(all(file.exists(filenames))) return(filenames)
  anthrome <- rast(anthrome_url)
  names(anthrome) <- c("urban_areas", "cultivated_areas")
  writeRaster(anthrome, filenames, overwrite = TRUE)
  filenames
}

ipbes_biome_classes <- data.frame(
  class = c(1:15),
  name = c("tropical and subtropical dry and humid forests",
           "temperate and boreal forests and woodland",
           "mediterranean forests woodlands and scrub",
           "tundra and high mountain habitats",
           "tropical and subtropical savannas and grasslands",
           "temperate grassland",
           "deserts and xeric shrubland",
           "wetlands",
           "urban and semi-urban areas",
           "cultivated areas",
           "cyrosphere",
           "aquaculture areas",
           "inland surface waters and water bodies",
           "shelf ecosystems",
           "open ocean pelagic systems")
)

.register(list(
    name = "ipbes_anthrome",
    type = "raster",
    source = "https://zenodo.org/records/3975694",
    fun = .get_ipbes_anthrome,
    arguments = list()),
    "resource")


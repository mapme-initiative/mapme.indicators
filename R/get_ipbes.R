#' Terrestrial and Aquatic Biomes
#'
#' This resource is part of the Global Assessment Report on Biodiversity and
#' Ecosystem Services and represents a division of the Earth's surface
#' into several subcategories. The classification differentiates between
#' biomes and anthromes. Biomes are differentiated between terrestrial and aquatic
#' biomes.
#'
#' Terrestrial biomes include:
#' - Tropical and subtropical dry and humid forests
#' - Temperate and boreal forests and woodlands
#' - Mediterranean forests, woodlands and scrub
#' - Tundra and High Mountain habitats
#' - Tropical and subtropical savannas and grasslands
#' - Temperate Grasslands
#' - Deserts and xeric shrublands
#' - Wetlands – peatlands, mires, bogs
#'
#' Aquatic biomes include:
#' - Cryosphere
#' - Aquaculture areas
#' - Inland surface waters and water bodies/freshwater
#' - Shelf ecosystems (neritic and intertidal/littoral zone)
#' - Open ocean pelagic systems (euphotic zone)
#'
#' @name ipbes
#' @keywords resource
#' @returns A function that returns a character vector of file paths.
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
#' @export
get_ipbes_biomes <- function() {
  function(
    x,
    name = "ipbes_biomes",
    type = "raster",
    outdir = mapme_options()[["outdir"]],
    verbose = mapme_options()[["verbose"]],
    testing = mapme_options()[["testing"]]) {

    biome_url <- "/vsicurl/https://zenodo.org/records/3975694/files/IPBES_UoA_biomes_JK.tif"
    filename <- file.path(outdir, basename(biome_url))
    if(file.exists(filename)) return(filename)
    biome <- rast(biome_url)
    levels(biome) <- .ipbes_biome_classes
    writeRaster(biome, filename)
    filename
  }
}

.ipbes_biome_classes <- data.frame(
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

register_resource(
  name = "ipbes_biomes",
  description = "Global Assessment Report on Biodiversity and Ecosystem Services division of the earth's surface into biomes and anthromes.",
  licence = "CC 4.0",
  source = "https://zenodo.org/records/3975694",
  type = "raster"
)

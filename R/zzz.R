.onLoad <- function(libname,pkgname) {

  mapme.biodiversity::register_resource(
    name = "humanfootprint",
    type = "raster",
    source = "https://figshare.com/articles/figure/An_annual_global_terrestrial_Human_Footprint_dataset_from_2000_to_2018/16571064",
    fun = .get_hfp,
    arguments = list()
  )

  mapme.biodiversity::register_indicator(
    name = "humanfootprint",
    resources = list(humanfootprint = "raster"),
    fun = .calc_hfp,
    arguments = list(
      engine = "extract",
      stats_hfp = "mean"
    ),
    processing_mode = "asset"
  )

  mapme.biodiversity::register_resource(
    name = "ipbes_biome",
    type = "raster",
    source = "https://zenodo.org/records/3975694",
    fun = .get_ipbes_biome,
    arguments = list()
  )

  mapme.biodiversity::register_resource(
    name = "ipbes_anthrome",
    type = "raster",
    source = "https://zenodo.org/records/3975694",
    fun = .get_ipbes_anthrome,
    arguments = list()
  )

  mapme.biodiversity::register_indicator(
    name = "ipbes_anthrome",
    resources = list(ipbes_anthrome = "raster"),
    fun = .calc_ipbes_anthrome,
    arguments = list(anthrome = "both"),
    processing_mode = "portfolio"
  )

  mapme.biodiversity::register_indicator(
    name = "ipbes_biome",
    resources = list(ipbes_biome = "raster"),
    fun = .calc_ipbes_biome,
    arguments = list(),
    processing_mode = "portfolio"
  )


}


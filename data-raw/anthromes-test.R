library(LLFindicators)
library(sf)
library(future)
library(progressr)


aoi <- st_read("../portfolio_tc_donors.gpkg")
aoi <- init_portfolio(aoi, years = 1992:2015, outdir = "../data/", verbose = T)

# CCI
cci <- get_resources(aoi, "cci")

plan(multisession, workers = 6)
with_progress({
  cci <- calc_indicators(cci, "cci_anthromes", anthrome_values = c(10, 20, 30, 40, 190))
})
plan(sequential)


# IBPEs
ibpes <- get_resources(aoi, "ipbes_anthrome")

plan(multisession, workers = 6)
with_progress({
  ibpes <- calc_indicators(ibpes, "ipbes_anthrome_stats", anthrome = "both")
})
plan(sequential)


ibpes[["ipbes_anthrome_stats"]][[11]]
cci[["cci_anthromes"]][[11]]


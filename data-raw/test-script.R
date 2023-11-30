library(senkenberg)
library(progressr)
library(future)

polys <- st_read("data-raw/automatically_cleaned.gpkg")
port <- init_portfolio(polys, years = 2010:2015, outdir = "data-raw/", add_resources = FALSE)
port <- get_resources(port, "humanfootprint")


plan(multisession, workers = 8)
timing <- system.time(with_progress({
port2 <- calc_indicators(port, "humanfootprint", engine = "extract", stats_hfp = "mean")
}))
plan(sequential)

port2$humanfootprint


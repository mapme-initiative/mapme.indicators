#' @noRd
#' @include zzz.R
#' @importFrom RCurl getURL
.get_cci <- function(
    x,
    rundir = tempdir(),
    verbose = TRUE) {

  target_years <- attributes(x)$years
  available_years <- 1992:2015
  target_years <- mapme.biodiversity:::.check_available_years(
    target_years, available_years, "cci"
  )

  url <- "ftp://geo10.elie.ucl.ac.be/CCI/LandCover/byYear/"
  server_files <- getURL(url, verbose=verbose,ftp.use.epsv=TRUE, dirlistonly = TRUE)
  server_files <- strsplit(server_files, "\n")[[1]]
  server_files <- grep(paste(target_years, collapse = "|"), server_files, value = TRUE)
  server_files <- grep(".tif$", server_files, value = TRUE)
  server_files <- file.path(url, server_files)
  filenames <- file.path(rundir, basename(server_files))

  filenames <- mapme.biodiversity:::.download_or_skip(
    server_files,
    filenames,
    verbose = verbose,
    check_existence = FALSE)

  filenames
}


.register(list(
  name = "cci",
  type = "raster",
  source = "https://figshare.com/articles/figure/An_annual_global_terrestrial_Human_Footprint_dataset_from_2000_to_2018/16571064",
  fun = .get_cci,
  arguments = list()),
  "resource")

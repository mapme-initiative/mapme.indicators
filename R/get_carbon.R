#' @noRd
#' @include zzz.R
.get_irr_carbon <- function(
    x,
    rundir = tempdir(),
    verbose = TRUE) {

  files_df <- .get_goldstein_url("^Irrecoverable_Carbon_\\d{4}\\.zip$")
  filenames <- file.path(rundir, files_df[["filename"]])
  filenames <- mapme.biodiversity:::.download_or_skip(
    urls = files_df[["url"]],
    filenames = filenames,
    verbose = verbose,
    check_existence = FALSE)

  purrr::walk(filenames, function(x) mapme.biodiversity:::.unzip_and_remove(x, rundir = rundir, remove = FALSE))
  list.files(rundir, pattern = "*.tif$", recursive = TRUE, full.names = TRUE)

}

.register(list(
  name = "irr_carbon",
  type = "raster",
  source = "https://zenodo.org/records/4091029",
  fun = .get_irr_carbon,
  arguments = list()),
  "resource")

#' @noRd
#' @include zzz.R
.get_vul_carbon <- function(
    x,
    rundir = tempdir(),
    verbose = TRUE) {

  files_df <- .get_goldstein_url("^Vulnerable_Carbon_\\d{4}\\.zip$")
  filenames <- file.path(rundir, files_df[["filename"]])
  filenames <- mapme.biodiversity:::.download_or_skip(
    urls = files_df[["url"]],
    filenames = filenames,
    verbose = verbose,
    check_existence = FALSE)

  purrr::walk(filenames, function(x) mapme.biodiversity:::.unzip_and_remove(x, rundir = rundir, remove = FALSE))
  list.files(rundir, pattern = "*.tif$", recursive = TRUE, full.names = TRUE)

}

.register(list(
  name = "vul_carbon",
  type = "raster",
  source = "https://zenodo.org/records/4091029",
  fun = .get_vul_carbon,
  arguments = list()),
  "resource")

#' @noRd
#' @include zzz.R
.get_man_carbon <- function(
    x,
    rundir = tempdir(),
    verbose = TRUE) {

  files_df <- .get_goldstein_url("^Manageable_Carbon_\\d{4}\\.zip$")
  filenames <- file.path(rundir, files_df[["filename"]])
  filenames <- mapme.biodiversity:::.download_or_skip(
    urls = files_df[["url"]],
    filenames = filenames,
    verbose = verbose,
    check_existence = FALSE)

  purrr::walk(filenames, function(x) mapme.biodiversity:::.unzip_and_remove(x, rundir = rundir, remove = FALSE))
  list.files(rundir, pattern = "*.tif$", recursive = TRUE, full.names = TRUE)

}

.register(list(
  name = "man_carbon",
  type = "raster",
  source = "https://zenodo.org/records/4091029",
  fun = .get_man_carbon,
  arguments = list()),
  "resource")


.get_goldstein_url <- function(layer){
  baseurl <- "https://zenodo.org/api/records/4091029"
  cnt <- request(baseurl) |> req_perform() |> resp_body_json()
  files_df <- lapply(cnt[["files"]], function(x) data.frame(filename = x[["key"]], url = x[["links"]][["self"]]))
  files_df <- do.call(rbind, files_df)
  files_df[grep(layer, files_df[["filename"]]), ]
}

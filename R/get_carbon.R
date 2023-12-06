#' Irrecoverable Carbon Layer
#'
#' This resource is part of the publication by Noon et al. (2022) "Mapping the
#' irrecoverable carbon in Earth’s ecosystems". This publication differentiates
#' between 3 different kinds of carbon with varying degrees of manageability
#' by humans. All three layers are available for above and below ground
#' carbon, as well as a layer combining the two.
#'
#' Irrecoverable carbon is defined as the amount of carbon, that, if lost today,
#' cannot be recovered until mid 21st century (so within 30 years, considering
#' the publication date).
#'
#' @name irr_carbon
#' @docType data
#' @keywords resource
#' @format A global tiled raster resource available for all land areas.
#' @references Noon, M.L., Goldstein, A., Ledezma, J.C. et al. Mapping the
#'   irrecoverable carbon in Earth’s ecosystems. Nat Sustain 5, 37–46 (2022).
#'   https://doi.org/10.1038/s41893-021-00803-6
#' @source \url{https://zenodo.org/records/4091029}
NULL

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

#' Vulnerable Carbon Layer
#'
#' This resource is part of the publication by Noon et al. (2022) "Mapping the
#' irrecoverable carbon in Earth’s ecosystems". This publication differentiates
#' between 3 different kinds of carbon with varying degrees of manageability
#' by humans. All three layers are available for above and below ground
#' carbon, as well as a layer combining the two.
#'
#' Vulnerable carbon is defined as the amount of carbon that would be lost in a
#' hypothetical but typical conversion event (without including information
#' of the probability of such an event to be actually occurring).
#'
#' @name vul_carbon
#' @docType data
#' @keywords resource
#' @format A global tiled raster resource available for all land areas.
#' @references Noon, M.L., Goldstein, A., Ledezma, J.C. et al. Mapping the
#'   irrecoverable carbon in Earth’s ecosystems. Nat Sustain 5, 37–46 (2022).
#'   https://doi.org/10.1038/s41893-021-00803-6
#' @source \url{https://zenodo.org/records/4091029}
NULL

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


#' Manageable Carbon Layer
#'
#' This resource is part of the publication by Noon et al. (2022) "Mapping the
#' irrecoverable carbon in Earth’s ecosystems". This publication differentiates
#' between 3 different kinds of carbon with varying degrees of manageability
#' by humans. All three layers are available for above and below ground
#' carbon, as well as a layer combining the two.
#'
#' Manageable carbon is defined as all land areas, expect cyrosols, because
#' carbon loss is driven by direct land-use conversion which could be halted or
#' because climate change impacts affecting the area can potentially be directly
#' mitigated through adaptive management.
#'
#' @name man_carbon
#' @docType data
#' @keywords resource
#' @format A global tiled raster resource available for all land areas.
#' @references Noon, M.L., Goldstein, A., Ledezma, J.C. et al. Mapping the
#'   irrecoverable carbon in Earth’s ecosystems. Nat Sustain 5, 37–46 (2022).
#'   https://doi.org/10.1038/s41893-021-00803-6
#' @source \url{https://zenodo.org/records/4091029}
NULL

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

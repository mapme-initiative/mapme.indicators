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
#' @keywords resource
#' @returns A function that returns a character vector of file paths.
#' @references Noon, M.L., Goldstein, A., Ledezma, J.C. et al. Mapping the
#'   irrecoverable carbon in Earth’s ecosystems. Nat Sustain 5, 37–46 (2022).
#'   https://doi.org/10.1038/s41893-021-00803-6
#' @source \url{https://zenodo.org/records/4091029}
#' @importFrom mapme.biodiversity download_or_skip unzip_and_remove
#' @export
get_irr_carbon <- function() {

  function(
    x,
    name = "irr_carbon",
    type = "raster",
    outdir = mapme_options()[["outdir"]],
    verbose = mapme_options()[["verbose"]],
    testing = mapme_options()[["testing"]]) {

    files_df <- .get_goldstein_url("^Irrecoverable_Carbon_\\d{4}\\.zip$")
    filenames <- file.path(outdir, files_df[["filename"]])
    filenames <- download_or_skip(
      urls = files_df[["url"]],
      filenames = filenames,
      check_existence = FALSE)

    purrr::walk(filenames, function(x) unzip_and_remove(x, dir = outdir, remove = FALSE))
    list.files(outdir, pattern = "*.tif$", recursive = TRUE, full.names = TRUE)
  }
}

register_resource(
  name = "irr_carbon",
  description = "Amount of carbon irrecoverably lost by a typical land use conversion event until mid-century.",
  licence = "CC NC 4.0",
  source = "https://zenodo.org/records/4091029",
  type = "raster"
)

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
#' @keywords resource
#' @returns A function that returns a character vector of file paths.
#' @references Noon, M.L., Goldstein, A., Ledezma, J.C. et al. Mapping the
#'   irrecoverable carbon in Earth’s ecosystems. Nat Sustain 5, 37–46 (2022).
#'   https://doi.org/10.1038/s41893-021-00803-6
#' @source \url{https://zenodo.org/records/4091029}
#' @importFrom mapme.biodiversity download_or_skip unzip_and_remove
#' @export
get_vul_carbon <- function() {
  function(
    x,
    name = "vul_carbon",
    type = "raster",
    outdir = mapme_options()[["outdir"]],
    verbose = mapme_options()[["verbose"]],
    testing = mapme_options()[["testing"]]) {

    files_df <- .get_goldstein_url("^Vulnerable_Carbon_\\d{4}\\.zip$")
    filenames <- file.path(outdir, files_df[["filename"]])
    filenames <- download_or_skip(
      urls = files_df[["url"]],
      filenames = filenames,
      check_existence = FALSE)

    purrr::walk(filenames, function(x) unzip_and_remove(x, dir = outdir, remove = FALSE))
    list.files(outdir, pattern = "*.tif$", recursive = TRUE, full.names = TRUE)
  }
}

register_resource(
  name = "vul_carbon",
  description = "Amount of carbon that is vulnerable to a typical land use conversion event.",
  licence = "CC NC 4.0",
  source = "https://zenodo.org/records/4091029",
  type = "raster"
)


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
#' @keywords resource
#' @returns A function that returns a character vector of file paths.
#' @references Noon, M.L., Goldstein, A., Ledezma, J.C. et al. Mapping the
#'   irrecoverable carbon in Earth’s ecosystems. Nat Sustain 5, 37–46 (2022).
#'   https://doi.org/10.1038/s41893-021-00803-6
#' @source \url{https://zenodo.org/records/4091029}
#' @importFrom mapme.biodiversity download_or_skip unzip_and_remove
#' @export
get_man_carbon <- function() {
  function(
    x,
    name = "man_carbon",
    type = "raster",
    outdir = mapme_options()[["outdir"]],
    verbose = mapme_options()[["verbose"]],
    testing = mapme_options()[["testing"]]) {

    files_df <- .get_goldstein_url("^Manageable_Carbon_\\d{4}\\.zip$")
    filenames <- file.path(outdir, files_df[["filename"]])
    filenames <- download_or_skip(
      urls = files_df[["url"]],
      filenames = filenames,
      check_existence = FALSE)

    purrr::walk(filenames, function(x) unzip_and_remove(x, dir = outdir, remove = FALSE))
    list.files(outdir, pattern = "*.tif$", recursive = TRUE, full.names = TRUE)
  }
}

register_resource(
  name = "man_carbon",
  description = "Amount of carbon that is manageable by humans.",
  licence = "CC NC 4.0",
  source = "https://zenodo.org/records/4091029",
  type = "raster"
)


.get_goldstein_url <- function(layer){
  baseurl <- "https://zenodo.org/api/records/4091029"
  cnt <- resp_body_json(req_perform(request(baseurl)))
  files_df <- lapply(cnt[["files"]], function(x) data.frame(filename = x[["key"]], url = x[["links"]][["self"]]))
  files_df <- do.call(rbind, files_df)
  files_df[grep(layer, files_df[["filename"]]), ]
}

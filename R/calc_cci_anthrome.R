#' @noRd
#' @include zzz.R
.calc_cci_anthromes <- function(
    x,
    cci,
    anthrome_values = c(10, 20, 30, 40, 190),
    verbose = TRUE,
    ...) {

  if (is.null(cci)) return(NA)

  if (any(!anthrome_values %in% .cci_classes[["value"]])){
    org <- getOption("warning.length")
    on.exit(options(warning.length = org))
    options(warning.length = 1800)
    msg_df <-  paste(capture.output(print(.cci_classes)), collapse = "\n")
    stop(paste0("anthrome_values must be in:\n", msg_df))
  }

  anthrome_df <- data.frame(
    old_value = anthrome_values,
    new_value = seq_along(anthrome_values))

  cci_anthrome <- terra::classify(cci, anthrome_df, others = 0)

  class_df <- data.frame(
    value = c(0, seq_along(anthrome_values)),
    class = c("other", .cci_classes[["class"]][match(anthrome_values, .cci_classes[["value"]])]))

  layer_names <- names(cci)
  names(cci_anthrome) <- layer_names

  exactextractr::exact_extract(cci_anthrome, x, fun = function(data, cci_names, classes) {

    coverage_area <- data[["coverage_area"]] / 10000
    data <- as.data.frame(data[,-ncol(data)])
    names(data) <- cci_names

    results <- purrr:::imap_dfr(data, function(x, name, coverage, classes){
      year <- as.numeric(strsplit(name, "-")[[1]][8])

      stats <- by(coverage, x, sum)
      total <- sum(stats)

      stats <- tibble::tibble(
        affected = as.numeric(stats),
        value = as.numeric(dimnames(stats)[[1]]))

      stats <- merge(stats, classes, all = TRUE)
      stats[is.na(stats)] <- 0
      stats[["year"]] <- year
      stats[["percentage"]] <-  stats[["affected"]] / total * 100
      stats[["total"]] <- total
      stats <- stats[stats[["class"]] != "other", ]
      stats[c("year", "class", "affected", "percentage", "total")]
    }, coverage = coverage_area, classes = class_df)

    tibble::as_tibble(results)
  }, cci_names = layer_names, coverage_area = TRUE, summarize_df = TRUE)

}

.register(list(
  name = "cci_anthromes",
  resources = list(cci = "raster"),
  fun = .calc_cci_anthromes,
  arguments = list(
    anthrome_values = c(10, 20, 30, 40, 190)
  ),
  processing_mode = "asset"),
  "indicator")

.cci_classes <- data.frame(
  value = seq(0, 220, 10),
  class = c(
    "no data",
    "rainfed cropland",
    "irrigated cropland",
    "mosaic cropland (>50%) / natural vegetation (<50%)",
    "mosaic natural vegetation (>50%) / cropland (<50%)",
    "tree cover, broadleaved, evergreen, closed to open (>15%)",
    "tree cover, broadleaved, deciduous, closed to open (>15%)",
    "tree cover, needleleaved, evergreen, closed to open (>15)",
    "tree cover, needleleaved, deciduous, closed to open (>15%)",
    "tree cover, mixed leaf type (broadleaved and needleleaved)",
    "mosaic tree and shrub (>50%) / herbaceous cover (<50%)",
    "mosaic herbaceous cover (>50%) / tree and shrub (<50%)",
    "shrubland",
    "grassland",
    "lichens and mosses",
    "sparse vegetation (tree, shrub, herbaceous cover) (<15%)",
    "tree cover, flooded, fresh or brakish water",
    "tree cover, flooded, saline water",
    "shrub or herbaceous cover, flooded, fresh/saline/brakish water",
    "urban areas",
    "bare areas",
    "water bodies",
    "permanent snow and ice"
  )
)

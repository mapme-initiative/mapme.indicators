#' @include zzz.R
.calc_ipbes_biome <- function(
    x,
    ipbes_biome,
    verbose = TRUE) {

  if (is.null(ipbes_biome)) return(NA)

  results <- lapply(1:nrow(x), function(i) {
    exactextractr::exact_extract(ipbes_biome, x[i, ], fun = function(data, class_df){

      data[["coverage_area"]] <- data[["coverage_area"]] / 10000
      total_area <- sum(data[["coverage_area"]])
      class_area <- by(data[["coverage_area"]], data[["value"]], sum)
      result <- tibble::tibble(
        class = as.numeric(names(class_area)),
        area = as.numeric(class_area),
        percentage = as.numeric(class_area) / total_area * 100
      )
      result[["class"]] <- class_df[["name"]][result[["class"]]]
      result

    }, class_df = ipbes_biome_classes, coverage_area = TRUE, summarize_df = TRUE)
  })

  results
}

.register(list(
  name = "ipbes_biome",
  resources = list(ipbes_biome = "raster"),
  fun = .calc_ipbes_biome,
  arguments = list(),
  processing_mode = "portfolio"),
  "indicator")

#' @include zzz.R
.calc_ipbes_anthrome <- function(
    x,
    ipbes_anthrome,
    anthrome = c("urban_areas", "cultivated_areas", "both"),
    verbose = TRUE) {

  anthrome <- match.arg(anthrome)
  if (is.null(ipbes_anthrome)) return(NA)
  if (anthrome == "both") anthrome <- c("urban_areas", "cultivated_areas")
  names(ipbes_anthrome) <- c("urban_areas", "cultivated_areas")
  ipbes_anthrome <- ipbes_anthrome[[anthrome]]

  results <- lapply(1:nrow(x), function(i) {
    exactextractr::exact_extract(ipbes_anthrome, x[i, ], fun = function(data, anthrome){

      data[["coverage_area"]] <- data[["coverage_area"]] / 10000
      result <- lapply(anthrome, function(a){
        affected <- sum((data[[a]]/100) * data[["coverage_area"]])
        total = sum(data[["coverage_area"]])
        percent = affected / total * 100
        tibble::tibble(
          anthrome = a,
          affected = affected,
          percentage = percent,
          total = total
        )
      })
      do.call(rbind, result)

    }, anthrome = anthrome, coverage_area = TRUE, summarize_df = TRUE)
  })
  results
}

.register(list(
  name = "ipbes_anthrome",
  resources = list(ipbes_anthrome = "raster"),
  fun = .calc_ipbes_anthrome,
  arguments = list(anthrome = "both"),
  processing_mode = "portfolio"),
  "indicator")



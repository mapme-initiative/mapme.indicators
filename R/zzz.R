.pkgenv <- new.env(parent = emptyenv())

.pkgenv$resources <- list()
.pkgenv$indicators <- list()

.register <- function(x, what = c("resource", "indicator")){
  what <- match.arg(what)
  if (what == "resource") .pkgenv$resources <- append(.pkgenv$resources, list(x))
  if (what == "indicator") .pkgenv$indicators <- append(.pkgenv$indicators, list(x))
}

.onLoad <- function(libname,pkgname) {
  purrr::walk(.pkgenv$resources, function(x) do.call(mapme.biodiversity::register_resource, x))
  purrr::walk(.pkgenv$indicators, function(x) do.call(mapme.biodiversity::register_indicator, x))
}


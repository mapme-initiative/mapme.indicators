% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calc_ipbes.R
\name{ipbes_biome_stats}
\alias{ipbes_biome_stats}
\alias{calc_ipbes_biomes}
\title{Calculate areal statistics for IBPES Biomes}
\usage{
calc_ipbes_biomes()
}
\value{
A function that returns a tibble with columns for the class name,
its absolute and relative coverage within an asset.
}
\description{
This indicator calculates the areal distribution of different biome classes
within an asset based on the IBPES biomes dataset.
}
\details{
The required resources for this indicator are:
\itemize{
\item \link{ipbes}
}
}
\keyword{indicator}

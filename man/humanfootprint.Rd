% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calc_hfp.R, R/get_hfp.R
\name{humanfootprint}
\alias{humanfootprint}
\alias{calc_humanfootprint}
\alias{get_humanfootprint}
\title{Calculate human footprint statistics}
\source{
\url{https://figshare.com/articles/figure/An_annual_global_terrestrial_Human_Footprint_dataset_from_2000_to_2018/16571064}
}
\usage{
calc_humanfootprint(engine = "extract", stats = "mean")

get_humanfootprint(years = 2000:2020)
}
\arguments{
\item{engine}{The preferred processing functions from either one of "zonal",
"extract" or "exactextract" as character.}

\item{stats}{Function to be applied to compute statistics for polygons either
one or multiple inputs as character. Supported statistics are: "mean",
"median", "sd", "min", "max", "sum" "var".}

\item{years}{A numeric vector indicating the years for which to download
the human footprint data, defaults to \code{2000:2020}.}
}
\value{
A function that returns a tibble with a column for each statistic
and a row for every requested year.

A function that returns a character vector of file paths.
}
\description{
Human footprint data measures the pressure imposed on the natural environment
by different dimensions of human actions. The theoretical maximum value,
representing the highest level of human pressure, is 50. This routine allows
to extract zonal statistics of the human footprint data.

This resource is part of the publication by Mu et al. (2022) "A global
record of annual terrestrial Human Footprint dataset from 2000 to 2018".
It is calculated based on 8 variables representing human pressures on
natural ecosystems collected at a yearly cadence between 2000 and 2020
sampled at a 1km spatial resolution. The variables are used are
the expansion of built environments (expressed as percentage of built-up
areas within a grid cell), population density (aggregated at the gridd cell),
nighttime lights, crop and pasture lands, roads and railways (excluding trails
and minor roads), and navigable waterways (compares waterways with nighttime
lights dataset). The human footprint was then calculated based on a weighting
scheme proposed by Venter et al. (2016), assigning each pixel a value between
0 and 50, with 50 representing the theoretical value of the highest human
pressure.
}
\details{
The required resources for this indicator are:
\itemize{
\item \link{humanfootprint}
}

It may be required to increase the timeout option to successfully download
theses layers from their source location via e.g. \code{options(timeout = 600)}.
}
\references{
Mu, H., Li, X., Wen, Y. et al. A global record of annual
terrestrial Human Footprint dataset from 2000 to 2018. Sci Data 9, 176 (2022).
\doi{https://doi.org/10.1038/s41597-022-01284-8}
}
\keyword{indicator}
\keyword{resource}

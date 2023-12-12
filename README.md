# mapme.indicators

## Introduction

This package is work-in-progress. The aim is to support biodiversity related
indicators from the publication of [Voskamp et al. (2023)](https://www.cell.com/one-earth/fulltext/S2590-3322(23)00387-1)
to support enhanced targeting of conservation efforts.
At the same time it serves as an technical example how the core MAPME package
can be extended by third-parties.


## Installation

Currently, this package is compatible with the dev version of `{mapme.biodiversity}` only.
Please run the following code to install the packages:

```        
remotes::install_github("mapme-initiative/mapme.biodiversity", ref = "virtualize-tileindex")
remotes::install_github("mapme-initiative/mapme.indicators")
```

## Usage

The package adds a number of indicators used by the Legacy Landscape Fund to analyse protected areas. It is ready-to-use in a workflow based on\
`{mapme.biodiversity}`.

Once the package is loaded in your R session via `library(mapme.indicators)`, the new resources and associated indicators are registered and available for your workflows.

## Indicators

| Name                                     | Description                                                                                                             | Original Implementation                                                                                  | New Implementation                                                                | Data Source                                                                                                                                                                                                                                                  | Implemented |
|-----------|-----------|-----------|-----------|---------------------|-----------|
| Manageable carbon                        | carbon stock that is primarily affected by human activities that either maintain, increase, or decrease its size        | aggregated to tons per grid cell, then mean per PA                                                       | mean per PA                                                                       | [Zenodo](https://zenodo.org/records/4091029)                                                                                                                                                                                                                 | Yes         |
| Vulnearble carbon                        | amount of manageable carbon that is likely to be released through typical land conversion in an ecosystem               | aggregated to tons per grid cell, then mean per PA                                                       | mean per PA                                                                       | [Zenodo](https://zenodo.org/records/4091029)                                                                                                                                                                                                                 | Yes         |
| Irrecoverable carbon                     | amount of the vulnerable carbon which if it is lost through typical land conversion actions cannot be recovered by 2050 | aggregated to tons per grid cell, then mean per PA                                                       | mean per PA                                                                       | [Zenodo](https://zenodo.org/records/4091029)                                                                                                                                                                                                                 | Yes         |
| Human footprint                          | pressure on ecosystems by 8 variables of human impact                                                                   | aggregation to standard grid, mean per PA                                                                | mean calculation directly per PA                                                  | [Figshare](https://figshare.com/articles/figure/An_annual_global_terrestrial_Human_Footprint_dataset_from_2000_to_2018/16571064)                                                                                                                             | Yes         |
| Recent land-use change                   | area percentage changed from biome to anthrome                                                                          | timeseries 1992-2018, aggregated to standard grid, summed changes (%) per PA                             | calculate percentage of anthromes based on IPBES data for 2020                    | ESA CCI or [IPBES](https://zenodo.org/records/3975694)                                                                                                                                                                                                       | Yes         |
| PA size                                  | size of PA in km²                                                                                                       | area measurment                                                                                          | area measurment                                                                   | IUCN                                                                                                                                                                                                                                                         | Yes         |
| Species Richness                         | Number of distinct species                                                                                              | count of unique species within a PA per grid cell, mean over PA                                          | crop polygons to PA and count unique species                                      | [BirdLife International](http://datazone.birdlife.org/species/requestdis) [IUCN](https://www.iucnredlist.org/resources/spatial-data-download), [Global Assessment of Reptile Distributions](https://datadryad.org/stash/dataset/doi:10.5061/dryad.9cnp5hqmb) | No          |
| Species Endemism                         | Range-size rarity of species corrected by species richness                                                              | calculation of range-size rarity, corrected by dividing with species richness per grid cell, mean per PA | calculate total area for each species, then range-size rarity, later divide by SR | see above                                                                                                                                                                                                                                                    | No          |
| Evolutionary Diversity                   | Evolutionary uniqness of species composition                                                                            | calculation of phylogenetic endemism per grid cell, mean per PA                                          | tbd.                                                                              | see above                                                                                                                                                                                                                                                    | No          |
| Biodiversity Intactness Index (BII)      | Todays species abundance compared to modeled abundance in an intact ecosystem                                           | available as gridded product, mean per PA                                                                | mean calculation directly per PA                                                  | [NHM](https://data.nhm.ac.uk/dataset/global-map-of-the-biodiversity-intactness-index-from-newbold-et-al-2016-science)                                                                                                                                        | No          |
| Projected biodiversity change            | inverse of projected turnover in species as proxy for climate stability                                                 | involved modelling of different climate projection scenarios coupled with species distribution modelling | tbd.                                                                              | Hof et al. (2018)                                                                                                                                                                                                                                            | No          |
| Projected tree cover change              | Projected change in treecover by 2050 only accounting for climate change (not land use)                                 | percentage per grid cell, area weighted mean per PA                                                      | tbd.                                                                              | LPJ-GUESS                                                                                                                                                                                                                                                    | No          |
| Projected land-use change in buffer zone | projected change in land use by 2050                                                                                    | extraction of mean and maximum of all grid cells in a 50 km buffer                                       | tbd.                                                                              | SIMIP2b                                                                                                                                                                                                                                                      | No          |

## To-Do

-   [ ] add all resources and indicators agreed upon with PM
-   [ ] add proper roxygen documentation
-   [ ] list new resources and indicators in README
-   [ ] include sample data sets
-   [ ] write tests

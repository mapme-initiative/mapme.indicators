# mapme.indicators

## Introduction

This package is currently work-in-progress. It is going to be used to develop
new resources/indicators while `{mapme.biodiversity}` is undergoing a number of 
functionality changes. To learn more about the ongoing changes and their current
status, please visit the [announcement issue](https://github.com/mapme-initiative/mapme.biodiversity/issues/240).

The branch you are seeing here links against `{mapme.biodiversity}` v0.5.0.

We will update the resource/indicator functions developed here once a new
version is released.

After reaching all milestones in `{mapme.biodiversity}`, we will decide whether
to move the resources/indicators developed here into the main package or if
the resources/indicators will be moved here.


## Installation

Please run the following code to install the required packages:

```         
remotes::install_version("mapme-initiative/mapme.biodiversity", version = "0.5.0")
remotes::install_github("mapme-initiative/mapme.indicators")
```

## Resources and Indicators

The package adds new resources and indicators. It is ready-to-use in a 
workflow based on\ `{mapme.biodiversity}`.

Once the package is loaded in your R session via `library(mapme.indicators)`, 
the new resources and associated indicators are registered and available for 
your workflows.

The table below gives an overview of implemented and planned resources/indicators:


| Name                                | Description                                                                                                             | Original Implementation                                                                                  | New Implementation                                                                | Data Source                                                                                                                                                                                                                                                  | Implemented |
|------------|------------|------------|------------|------------|------------|
| Manageable carbon                   | carbon stock that is primarily affected by human activities that either maintain, increase, or decrease its size        | aggregated to tons per grid cell, then mean per PA                                                       | mean per PA                                                                       | [Zenodo](https://zenodo.org/records/4091029)                                                                                                                                                                                                                 | Yes         |
| Vulnerable carbon                   | amount of manageable carbon that is likely to be released through typical land conversion in an ecosystem               | aggregated to tons per grid cell, then mean per PA                                                       | mean per PA                                                                       | [Zenodo](https://zenodo.org/records/4091029)                                                                                                                                                                                                                 | Yes         |
| Irrecoverable carbon                | amount of the vulnerable carbon which if it is lost through typical land conversion actions cannot be recovered by 2050 | aggregated to tons per grid cell, then mean per PA                                                       | mean per PA                                                                       | [Zenodo](https://zenodo.org/records/4091029)                                                                                                                                                                                                                 | Yes         |
| Human footprint                     | pressure on ecosystems by 8 variables of human impact                                                                   | aggregation to standard grid, mean per PA                                                                | mean calculation directly per PA                                                  | [Figshare](https://figshare.com/articles/figure/An_annual_global_terrestrial_Human_Footprint_dataset_from_2000_to_2018/16571064)                                                                                                                             | Yes         |
| Species Richness                    | Number of distinct species                                                                                              | count of unique species within a PA per grid cell, mean over PA                                          | crop polygons to PA and count unique species                                      | [BirdLife International](http://datazone.birdlife.org/species/requestdis) [IUCN](https://www.iucnredlist.org/resources/spatial-data-download), [Global Assessment of Reptile Distributions](https://datadryad.org/stash/dataset/doi:10.5061/dryad.9cnp5hqmb) | No          |
| Species Endemism                    | Range-size rarity of species corrected by species richness                                                              | calculation of range-size rarity, corrected by dividing with species richness per grid cell, mean per PA | calculate total area for each species, then range-size rarity, later divide by SR | same as above                                                                                                                                                                                                                                                | No          |
| Biodiversity Intactness Index (BII) | Todays species abundance compared to modeled abundance in an intact ecosystem                                           | available as gridded product, mean per PA                                                                | mean calculation directly per PA                                                  | [NHM](https://data.nhm.ac.uk/dataset/global-map-of-the-biodiversity-intactness-index-from-newbold-et-al-2016-science)                                                                                                                                        | No          |
| Landscapemetrics                    | Landscape and patch level metrics of landcape intactness                                                                | not originally included                                                                                  | mean per PA based on yearly forest cover maps of GFW                              | [GFW](https://www.globalforestwatch.org/)                                                                                                                                                                                                                    | No          |


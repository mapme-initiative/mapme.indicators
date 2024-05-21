# mapme.indicators

## Introduction

This package is currently work-in-progress. It is going to be used to develop new resources/indicators while `{mapme.biodiversity}` is undergoing a number of functionality changes. To learn more about the ongoing changes and their current status, please visit the [announcement issue](https://github.com/mapme-initiative/mapme.biodiversity/issues/240).

The branch you are seeing here links against `{mapme.biodiversity}` v0.8.0.

We will update the resource/indicator functions developed here once a new version is released.

After reaching all milestones in `{mapme.biodiversity}`, we will decide whether to move the resources/indicators developed here into the main package or if the resources/indicators will be moved here.

## Installation

Please run the following code to install the required packages:

```         
remotes::install_version("mapme.biodiversity", version = "0.7.0")
remotes::install_github("mapme-initiative/mapme.indicators")
```

## Resources and Indicators

The package adds new resources and indicators. It is ready-to-use in a workflow based on `{mapme.biodiversity}`.

Once the package is loaded in your R session via `library(mapme.indicators)`, the new resources and associated indicators are registered and available for your workflows.

The table below gives an overview of implemented and planned resources/indicators:

| Name                    | Description                                                                                                             | Data Source                                                                                                                      |
|---------------|----------------------------|------------------------------|
| Manageable carbon       | carbon stock that is primarily affected by human activities that either maintain, increase, or decrease its size        | [Zenodo](https://zenodo.org/records/4091029)                                                                                     |
| Vulnerable carbon       | amount of manageable carbon that is likely to be released through typical land conversion in an ecosystem               | [Zenodo](https://zenodo.org/records/4091029)                                                                                     |
| Irrecoverable carbon    | amount of the vulnerable carbon which if it is lost through typical land conversion actions cannot be recovered by 2050 | [Zenodo](https://zenodo.org/records/4091029)                                                                                     |
| Human footprint         | pressure on ecosystems by 8 variables of human impact                                                                   | [Figshare](https://figshare.com/articles/figure/An_annual_global_terrestrial_Human_Footprint_dataset_from_2000_to_2018/16571064) |
| IPBES Biomes            | Terrestrial and aquatic classification of biomes according to IPBES                                                     | [Zenodo](https://zenodo.org/records/3975694)                                                                                     |
| Species Richness (IUCN) | Number of distinct species possibly by threat level                                                                     | [IUCN Redlist](https://www.iucnredlist.org/resources/other-spatial-downloads)                                                    |

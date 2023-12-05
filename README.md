# SLOcatoR

Update: given that the tonsil atlas reference has been included in [Azimuth](https://azimuth.hubmapconsortium.org/), we refer users to that application to annotate their single-cell transcriptomes using our reference. For a finer-grained annotation, we recommend users downloading their dataset of interest (e.g. CD4 T cells) using our [HCATonsilData](https://bioconductor.org/packages/release/data/experiment/html/HCATonsilData.html) package. The current form of SLOcatoR serves to provide a transparent package to show how we annotated our cells from the validation cohort and connected the different data modalities. This is exemplified with [the mapping and annotation of CD4 T cells from the validation cohort onto the discovery cohort](https://htmlpreview.github.io/?https://github.com/Single-Cell-Genomics-Group-CNAG-CRG/TonsilAtlas/blob/main/scRNA-seq/5-analysis_additional_samples/7.8-transfer_label_validation_cohort_CD4_T.html)



![](inst/images/SLOcatoR_workflow2.png)


## Installation

You can install the development version of SLOcatoR from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("massonix/SLOcatoR")
```


## Contact

If you have any doubts or suggestions feel free to contact us by [email](ramon.massoni@cnag.crg.eu) or on [twitter](https://twitter.com/rmassonix).

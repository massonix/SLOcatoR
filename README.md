# SLOcatoR

Update: given that the tonsil atlas reference has been included in [Azimuth](https://azimuth.hubmapconsortium.org/), we refer users to that application to annotate their single-cell transcriptomes using our reference. For a finer-grained annotation, we recommend users downloading their dataset of interest (e.g. CD4 T cells) using our [HCATonsilData](https://bioconductor.org/packages/release/data/experiment/html/HCATonsilData.html) package. The current form of SLOcatoR serves to provide a transparent package to show how we annotated our cells from the validation cohort and connected the different data modalities.


Old:

The goal of SLOcatoR is to annotate and visualize single-cell gene expression or chromatin accessibility profiles from secondary lymphoid organs (SLO) using the tonsil atlas as reference.

We have packages the functions we used in our project to connect the different data modalities and to annotate cells from the tumor microenvironment of mantle cell lymphoma (MCL). You can see two vignettes from the code release of the publication to see how SLOcatoR works:

* [Annotation of CD4 T cells from MCL](https://htmlpreview.github.io/?https://github.com/Single-Cell-Genomics-Group-CNAG-CRG/TonsilAtlas/blob/main/MCL/4-SLOcatoR/reports/01-CD4_T_label_transfer_102.html)
* [Transfer annotation and UMAP coordinates from RNA to CITE-seq in CD8 T cells](https://htmlpreview.github.io/?https://github.com/Single-Cell-Genomics-Group-CNAG-CRG/TonsilAtlas/blob/main/CITE-seq/harmonize_seurat_objects/harmonize_CD8_T_cite_seq.html)



![](inst/images/SLOcatoR_workflow2.png)


## Installation

You can install the development version of SLOcatoR from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("massonix/SLOcatoR")
```


## Contact

If you have any doubts or suggestions feel free to contact us by [email](ramon.massoni@cnag.crg.eu) or on [twitter](https://twitter.com/rmassonix).

#' Find Assay-specific Highly Variable Features
#'
#'scRNA-seq and snRNA-seq integrate very poorly (Mereu & Lafzi, 2020). This is
#'caused by the fact that both techniques sample transcripts from different
#'cellular compartments. Similarly, we have obtained a poor mixability after
#'integrating CITE-seq and scRNA-seq. To overcome it, we propose performing
#'feature extraction for each assay independently, and then taking the
#'intersection. In this setting, assay-dependent variable features are discarded,
#'and batch effects are largely mitigated.
#'
#'
#' @param seurat_obj a Seurat object
#' @param assay_var a character string specifying which variable in
#'   seurat_obj@meta.data contains the assay for each cell
#' @param n_features number of highly variable features to find per assay
#'
#' @return A character vector with all the highly variable features shared
#'   across assays
#'
#' @examples
#'
#' @importFrom Seurat SplitObject FindVariableFeatures VariableFeatures
#' @importFrom purrr map
#' @export
find_assay_specific_features <- function(seurat_obj,
                                         assay_var = "assay",
                                         n_features = 5000) {
  seurat_list <- SplitObject(seurat_obj, split.by = assay_var)
  seurat_list <- map(
    seurat_list,
    FindVariableFeatures,
    nfeatures = n_features
  )
  hvg <- map(seurat_list, VariableFeatures)
  shared_hvg <- Reduce(intersect, hvg)
  shared_hvg
}

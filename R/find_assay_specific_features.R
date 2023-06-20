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
#' @param x a Seurat object TODO or a SingleCellExperiment object
#' @param assay_var a character string specifying which variable in
#'   seurat_obj@meta.data contains the assay for each cell
#' @param n_features number of highly variable features to find per assay
#'
#' @return A character vector with all the highly variable features shared
#'   across assays
#'
#' @examples
#'
#' ## TODO TODO
#'
#' @importFrom Seurat SplitObject FindVariableFeatures VariableFeatures
#' @importFrom SingleCellExperiment SingleCellExperiment colData rowData
#' @importFrom purrr map
#' @export
find_assay_specific_features <- function(x,
                                         assay_var = "assay",
                                         n_features = 5000) {

  .check_input(x)

  # function specific checks - TODO
  stopifnot(
    # assay_var
    is.character(assay_var),
    length(assay_var) == 1,
    # n_features
    is.numeric(n_features),
    n_features > 0
  )

  if (is(x, "Seurat")) {
    seurat_list <- SplitObject(x, split.by = assay_var)
    seurat_list <- map(
      seurat_list,
      FindVariableFeatures,
      nfeatures = n_features
    )
    hvg <- map(seurat_list, VariableFeatures)
    shared_hvg <- Reduce(intersect, hvg)
    shared_hvg
  } else if (is(x, "SingleCellExperiment")) {
    ## TODO:
    # writeup the correspondent code for an SCE object

    # TODO: we need something (lapply?) on the different components

    # TODO
    # TODO
    # TODO
    # consider: we need to provide A LIST of SCE objects?

  }

  # TODO: think if there is some portion of code we can "have in common" to avoid
  # excessive duplication
  # e.g. could be also the simple merging of different elements from the hvg list
  # the same is to apply/consider for the other functions

  return(shared_hvg)
}

### ORIGINAL
### find_assay_specific_features <- function(seurat_obj,
###                                          assay_var = "assay",
###                                          n_features = 5000) {
###   seurat_list <- SplitObject(seurat_obj, split.by = assay_var)
###   seurat_list <- map(
###     seurat_list,
###     FindVariableFeatures,
###     nfeatures = n_features
###   )
###   hvg <- map(seurat_list, VariableFeatures)
###   shared_hvg <- Reduce(intersect, hvg)
###   shared_hvg
### }


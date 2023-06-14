#' Integrate Assays
#'
#' This function leverages Harmony (10.1038/s41592-019-0619-0) and the shared
#' highly variable genes obtained with find_assay_specific_features, to correct
#' for batch effects between assays. Harmony is amongst the best-performing and
#' fastest batch effect correction tools (10.1186/s13059-019-1850-9).
#'
#'
#' @param seurat_obj a Seurat object
#' @param assay_specific logical indicating whether to perform the integration
#'   in an assay-specific fashion or not.
#' @param assay_var a character string specifying which variable in
#'   seurat_obj@meta.data contains the assay for each cell
#' @param shared_hvg a character vector with all the highly variable features shared
#'   across assays (output of find_assay_specific_features)
#' @param n_dim Number of dimensions (principal components) to use as input to
#'   Harmony
#'
#' @return A Seurat object with an additional "harmony" slot in seurat_obj@reductions
#'
#' @examples
#'
#' ## TODO TODO
#'
#' @importFrom magrittr %>%
#' @importFrom Seurat ScaleData RunPCA
#' @importFrom harmony RunHarmony
#' @export
integrate_assays <- function(seurat_obj,
                             assay_specific = TRUE,
                             assay_var = "assay",
                             shared_hvg,
                             n_dim = 30
) {
  if (assay_specific) {
    seurat_obj <- seurat_obj %>%
      ScaleData(features = shared_hvg) %>%
      RunPCA(features = shared_hvg) %>%
      RunHarmony(group.by.vars = assay_var, reduction = "pca", dims = seq_len(n_dim))
  } else {
    seurat_obj <- seurat_obj %>%
      ScaleData() %>%
      RunPCA()
  }

  seurat_obj
}

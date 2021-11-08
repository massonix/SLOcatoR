#' Integrate Single-Cell Chromatin Accessibility Profiles
#'
#' Run the standard scATAC-seq pipeline with Signac (10.1038/s41592-021-01282-5)
#' and correct for batch effects using Harmony (10.1038/s41592-019-0619-0).
#'
#' @param seurat_obj a Seurat object
#' @param n_dim number of dimensions (principal components) to use as input to
#'   Harmony
#' @param assay_use a character string specifying which variable in
#'   seurat_obj@meta.data contains the assay for each cell
#' @param group_by_vars a character string specifying which variable in
#'   seurat_obj@meta.data contains Harmony should consider as batch
#' @param reduction character string specifying the reduction inside
#'   seurat_obj@reductions to use. "harmony" by default
#'
#' @return A Seurat object.
#' @export
#'
#' @examples
integrate_assays_atac <- function(seurat_obj,
                                  n_dim = 40,
                                  assay_use,
                                  group_by_vars,
                                  reduction) {
  seurat_obj <- seurat_obj %>%
    RunTFIDF() %>%
    FindTopFeatures(min.cutoff = "q0") %>%
    RunSVD() %>%
    RunHarmony(
      group.by.vars = group_by_vars,
      reduction = reduction,
      dims = 2:n_dim,
      assay.use = assay_use,
      project.dim = FALSE
    )
  seurat_obj
}

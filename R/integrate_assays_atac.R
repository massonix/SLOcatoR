#' Title
#'
#' @param seurat_obj
#' @param n_dim
#' @param assay_use
#' @param group_by_vars
#' @param reduction
#'
#' @return
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

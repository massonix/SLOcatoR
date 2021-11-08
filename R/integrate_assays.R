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
      RunHarmony(group.by.vars = assay_var, reduction = "pca", dims = 1:n_dim)
  } else {
    seurat_obj <- seurat_obj %>%
      ScaleData() %>%
      RunPCA()
  }

  seurat_obj
}

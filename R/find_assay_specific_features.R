find_assay_specific_features <- function(seurat_obj,
                                         assay_var = "assay",
                                         n_features = 5000) {
  seurat_list <- SplitObject(seurat_obj, split.by = assay_var)
  seurat_list <- purrr::map(
    seurat_list,
    FindVariableFeatures,
    nfeatures = n_features
  )
  hvg <- purrr::map(seurat_list, VariableFeatures)
  shared_hvg <- Reduce(intersect, hvg)
  shared_hvg
}

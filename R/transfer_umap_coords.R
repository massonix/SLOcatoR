transfer_umap_coords <- function(seurat_obj,
                                 training_set,
                                 test_set,
                                 umap1_var,
                                 umap2_var,
                                 k) {
  train_umap_1 <- seurat_obj@meta.data[rownames(training_set), umap1_var]
  train_umap_2 <- seurat_obj@meta.data[rownames(training_set), umap2_var]
  knn_mod_umap_1 <- knnreg(x = training_set, y = train_umap_1, k = k)
  knn_mod_umap_2 <- knnreg(x = training_set, y = train_umap_2, k = k)
  umap_1_pred <- predict(knn_mod_umap_1, newdata = as.data.frame(test_set))
  umap_2_pred <- predict(knn_mod_umap_2, newdata = as.data.frame(test_set))
  umap_pred_df <- data.frame(
    query_cells = rownames(test_set),
    UMAP1 = umap_1_pred,
    UMAP2 = umap_2_pred
  )
  umap_pred_df
}

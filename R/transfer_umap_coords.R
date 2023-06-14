#' Transfer UMAP coordinates from training set to test set using KNN regression
#'
#' @param seurat_obj a Seurat object
#' @param training_set a matrix of cells x features. Usually corresponds to the
#'   "training_set" element in the list obtained with split_training_and_test_sets
#' @param test_set a matrix of cells x features. Usually corresponds to the
#'   "test_set" element in the list obtained with split_training_and_test_sets
#' @param umap1_var a character string specifying which variable in
#'   seurat_obj@meta.data contains the UMAP1 coordinates
#' @param umap2_var a character string specifying which variable in
#'   seurat_obj@meta.data contains the UMAP2 coordinates
#' @param k numeric specifying the size of the neighborhood
#'
#' @return A data.frame that contains the predicted UMAP1 and UMAP2 coords for
#'   each cell.
#'
#' @examples
#'
#' ## TODO TODO
#'
#' @importFrom caret knnreg
#' @importFrom stats predict
#' @export
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

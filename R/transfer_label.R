#' Transfer label from training set to test set using a KNN classifier
#'
#'
#'
#' @param seurat_obj a Seurat object
#' @param training_set a matrix of cells x features. Usually corresponds to the
#'   "training_set" element in the list obtained with split_training_and_test_sets
#' @param test_set a matrix of cells x features. Usually corresponds to the
#'   "test_set" element in the list obtained with split_training_and_test_sets
#' @param response_var character string specifying which variable in
#'   seurat_obj@meta.data contains the response variable
#' @param k numeric specifying the size of the neighborhood
#'
#' @return A data.frame that contains the predicted annotation and annotation
#'    probability (estimated accuracy) for each cell.
#'
#' @examples
#'
#' ## TODO TODO
#'
#' @importFrom class knn
#' @export
transfer_label <- function(seurat_obj,
                           training_set,
                           test_set,
                           response_var,
                           k) {
  training_labels <- seurat_obj@meta.data[rownames(training_set), response_var]
  knn_mod <- knn(
    train = training_set,
    test = test_set,
    cl = training_labels,
    k = k,
    prob = TRUE
  )
  test_labels_df <- data.frame(
    query_cells = rownames(test_set),
    annotation = as.character(knn_mod),
    annotation_prob = attr(knn_mod, "prob")
  )
  test_labels_df
}

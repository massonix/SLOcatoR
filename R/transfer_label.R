#' Title
#'
#' @param seurat_obj
#' @param training_set
#' @param test_set
#' @param response_var
#' @param k
#'
#' @return
#' @export
#'
#' @examples
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

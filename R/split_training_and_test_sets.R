#' Split dataset into training and test sets
#'
#' Create training (reference) and test (query) sets to use as input for
#' KNN classification and regression. Since integrate_assays corrects for
#' batch effects between the different assays, we commonly use batch effect-
#' corrected principal components (harmony components) as features.
#'
#' @param seurat_obj a Seurat object
#' @param split_var a character string specifying which variable in
#'   seurat_obj@meta.data distinguishes between training and test cells
#' @param referece_label a character string with the level that identifies
#'   training (reference) cells
#' @param query_label a character string with the level that identifies
#'   test (reference) cells
#' @param reduction  character string specifying the reduction inside
#'   seurat_obj@reductions to use. "harmony" by default
#' @param n_dims number of dimensions to use. 30 by default
#' @return A list with two matrices (cells x features): training and test sets.
#' @export
#'
#' @examples
split_training_and_test_sets <- function(seurat_obj,
                                         split_var,
                                         referece_label,
                                         query_label,
                                         reduction = "harmony",
                                         n_dims = 30) {
  # Training and test sets are composed by the reference and query cells
  cells <- colnames(seurat_obj)
  reference_cells <- cells[seurat_obj@meta.data[[split_var]] == referece_label]
  query_cells <- cells[seurat_obj@meta.data[[split_var]] == query_label]


  # Batch-corrected principal components are used as explanatory variables
  cell_embeddings <- Embeddings(seurat_obj, reduction = "harmony")
  training_set <- cell_embeddings[reference_cells, 1:n_dims]
  test_set <- cell_embeddings[query_cells, 1:n_dims]
  list(training_set = training_set, test_set = test_set)
}

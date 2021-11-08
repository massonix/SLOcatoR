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

find_optimal_k <- function(seurat_obj,
                           training_set,
                           response_var,
                           ks = c(2, 4, 6, 8, 16, 32, 64, 128, 256),
                           return_plot = TRUE) {
  indices <- sample(
    1:nrow(training_set),
    size = nrow(training_set) * 0.7,
    replace = FALSE
  )
  train_loan  <- training_set[indices, ] # 70% training data
  test_loan <- training_set[-indices, ] # remaining 30% test data
  train_labels <- seurat_obj@meta.data[rownames(train_loan), ][[response_var]]
  test_labels <- seurat_obj@meta.data[rownames(test_loan), ][[response_var]]

  k_optm <- c()
  k_values <- c()

  for (i in ks) {
    print(i)
    knn_mod <- knn(
      train = train_loan,
      test = test_loan,
      cl = train_labels,
      k = i
    )
    k_optm <- c(k_optm, mean(test_labels == knn_mod) * 100)
    k_values <- c(k_values, i)
  }

  k_df <- data.frame(k = k_values, accuracy = k_optm)

  if (return_plot) {
    p <- ggplot(k_df, aes(k, accuracy)) +
      geom_line() +
      geom_point() +
      theme_bw()
    return(list(df = k_df, plot = p))

  } else {
    return(k_df)
  }
}

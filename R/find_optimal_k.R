#' Find Optimal K
#'
#' The key parameter in K nearest-neighbors (KNN) classification and regression
#' is the size of the neighborhood (K). Although we have obtained reasonable
#' results with Ks between 5-30, this function allows to test the accuracy of
#' the classifier as a function of different choices of K to select the most
#' optimal one.
#'
#' @param seurat_obj a Seurat object
#' @param training_set a matrix of cells x features. Usually corresponds to the
#'   "training_set" element in the list obtained with split_training_and_test_sets
#' @param response_var character string specifying which variable in
#'   seurat_obj@meta.data contains the response variable
#' @param ks numeric vector that contains the potential K
#' @param return_plot logical indicating whether or not to return a plot with
#' the accuracy as a function of K
#'
#' @return If return_plot is set to False, it returns a data.frame with the
#'   expected accuracy for each k. If return_plot is set to True, it returns
#'   a list with the data.frame and the plot.
#' @export
#'
#' @examples
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

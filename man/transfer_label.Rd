% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/transfer_label.R
\name{transfer_label}
\alias{transfer_label}
\title{Transfer label from training set to test set using a KNN classifier}
\usage{
transfer_label(seurat_obj, training_set, test_set, response_var, k)
}
\arguments{
\item{seurat_obj}{a Seurat object}

\item{training_set}{a matrix of cells x features. Usually corresponds to the
"training_set" element in the list obtained with split_training_and_test_sets}

\item{test_set}{a matrix of cells x features. Usually corresponds to the
"test_set" element in the list obtained with split_training_and_test_sets}

\item{response_var}{character string specifying which variable in
seurat_obj@meta.data contains the response variable}

\item{k}{numeric specifying the size of the neighborhood}
}
\value{
A data.frame that contains the predicted annotation and annotation
probability (estimated accuracy) for each cell.
}
\description{
Transfer label from training set to test set using a KNN classifier
}
\examples{

}

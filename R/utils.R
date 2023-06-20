


## TODO; this will be an internal function we apply to all the times we
## encounter an sce/Seurat object

#' Check input to functions
#'
#' Internal function
#'
#' @param x TODO A Seurat or SingleCellExperiment object
#'
#' @return Invisible NULL if no error is triggered
#' @importFrom methods is
.check_input <- function(x) {
  # checks on the provided object
  stopifnot(
    # Check x inputs
    is(x, "Seurat") | is(x, "SingleCellExperiment")

    # if some elements in it are required, also check this here
    # e.g. you need colData or so? ask for it here
  )

  # no need to return anything, this is internal just to check the commonly
  # expected checks - throw an error if any of the conditions above is NOT verified

  invisible(NULL)
}

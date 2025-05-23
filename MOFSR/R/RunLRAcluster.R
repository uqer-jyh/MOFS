#' @title Run Low-Rank Approximation Clustering (LRAcluster) for Multi-Modality Data Integration
#' @description This function performs clustering analysis using Low-Rank Approximation Clustering (LRAcluster) to integrate multiple omics datasets. LRAcluster helps reduce the dimensionality of multiple data types while retaining key structures, facilitating effective clustering.
#' @author Zaoqu Liu; Email: liuzaoqu@163.com
#' @param data A list of matrices where each element represents a different modality (e.g., RNA, protein, methylation). Each matrix should have rows as features and columns as samples.
#' @param N.clust Integer. Number of clusters to create from the hierarchical clustering of the LRAcluster components (optional but recommended).
#' @param data.types A list specifying the type of data for each modality. Options include "binary", "gaussian", or "poisson". Default is c("binary", "gaussian").
#' @param data.names Character vector. Names of the datasets (optional).
#' @param cluster.algorithm Character. The clustering algorithm to use for hierarchical clustering (default: "ward.D2").
#' @return A data frame with the following columns:
#'   - Sample: The sample identifier.
#'   - Cluster: The assigned cluster number for each sample.
#'   - Cluster2: The assigned cluster label, prefixed by 'LRAcluster' to indicate that the clustering was performed using LRAcluster.
#' @details This function uses LRAcluster to integrate multiple data matrices and then performs hierarchical clustering on the resulting components to identify clusters. LRAcluster is particularly useful for reducing the dimensionality of high-dimensional omics data while retaining the most informative features.
#'
#' The function operates as follows:
#' 1. Each matrix in the input list is converted to a matrix to ensure compatibility.
#' 2. LRAcluster is performed to extract components that summarize the shared variation across different modalities.
#' 3. Hierarchical clustering is applied to the concatenated components to assign each sample to a cluster.
#' 4. The function returns a data frame containing the cluster assignment for each sample, along with additional information about the clustering process.
#' @references Wu D, Wang D, Zhang MQ, Gu J. Fast dimension reduction and integrative clustering of multi-omics data using low-rank approximation: application to cancer molecular classification. BMC Genomics. 2015;16:1022. doi:10.1186/s12864-015-2223-8.
#' @examples
#' # Example usage:
#' data1 <- matrix(rnorm(10000), nrow = 100, ncol = 100)
#' data2 <- matrix(rnorm(10000), nrow = 100, ncol = 100)
#' colnames(data1) <- colnames(data2) <- paste0("Sample", 1:100)
#' data_list <- list(data1, data2)
#'
#' # Run LRAcluster clustering
#' result <- RunLRAcluster(
#'   data = data_list, N.clust = 3,
#'   data.types = c("gaussian", "gaussian")
#' )
#'
#' @export
RunLRAcluster <- function(data = NULL, N.clust = NULL,
                          data.types = list("binary", "gaussian", "gaussian", "gaussian", "gaussian", "gaussian"),
                          data.names = NULL,
                          cluster.algorithm = "ward.D2") {
  # Set seed for reproducibility
  set.seed(1)

  # Check if required packages are installed
  if (!requireNamespace("LRAcluster", quietly = TRUE)) {
    if (!requireNamespace("devtools", quietly = TRUE)) {
      install.packages("devtools")
    }
    devtools::install_github("Zaoqu-Liu/LRAcluster")
  }

  # Input validation checks
  if (!is.list(data)) {
    stop("The 'data' parameter must be a list of matrices.")
  }

  # Convert each element to a matrix to ensure compatibility
  data <- lapply(data, as.matrix)

  # Perform LRAcluster
  fit <- LRAcluster::LRAcluster(data = data, types = data.types, dimension = N.clust, names = data.names)

  # Perform hierarchical clustering on the LRAcluster components
  clust <- stats::hclust(stats::dist(t(fit$coordinate)), method = cluster.algorithm) %>%
    stats::cutree(k = N.clust)

  # Create a data frame with cluster assignments
  clustres <- data.frame(
    Sample = colnames(data[[1]]),
    Cluster = clust,
    Cluster2 = paste0("LRAcluster", clust),
    row.names = colnames(data[[1]]),
    stringsAsFactors = FALSE
  )

  # Print summary of clustering results
  cat(paste0("Cluster algorithm: LRAcluster\n"))
  if (!is.null(N.clust)) {
    cat(paste0("Selection of cluster number: ", N.clust, "\n"))
    cluster_summary <- paste(
      paste0("C", 1:N.clust),
      round(table(clustres$Cluster) / nrow(clustres), 2) * 100,
      sep = " = "
    )
    cat(paste(cluster_summary, collapse = "% "), "%\n")
  } else {
    cat("Number of clusters was determined automatically by LRAcluster.\n")
  }

  return(clustres)
}

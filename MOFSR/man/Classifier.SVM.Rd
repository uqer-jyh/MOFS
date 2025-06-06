% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Classifier.SVM.R
\name{Classifier.SVM}
\alias{Classifier.SVM}
\title{Support Vector Machine (SVM) Classifier for Cluster Prediction}
\usage{
Classifier.SVM(
  data.test,
  data.train,
  cluster.data,
  cluster.markers,
  scale = TRUE
)
}
\arguments{
\item{data.test}{A numeric matrix or data frame of test data. Rows represent genes, and columns represent samples.}

\item{data.train}{A numeric matrix or data frame of training data. Rows represent genes, and columns represent samples.}

\item{cluster.data}{A data frame where the first column must be the sample IDs and the second column must be the cluster assignments. The sample IDs must match the column names of the training data.}

\item{cluster.markers}{A list of data frames, each containing markers for a specific cluster, with columns 'Gene' indicating gene names.}

\item{scale}{A logical value indicating whether to scale the test data. Default is TRUE.}
}
\value{
A data frame with:
  - ID: The sample identifier.
  - Probabilities: The probabilities for each cluster assignment.
  - Predict: The predicted cluster label for each sample.
}
\description{
This function performs classification using Support Vector Machine (SVM) to predict cluster assignments for test data based on trained models from training data and cluster markers.
}
\details{
The function operates as follows:
1. Ensures that the `cluster.data` has the correct column names.
2. Adds a one-hot encoded matrix for cluster assignments.
3. Scales the test data for prediction.
4. Selects genes that are common between the test and training datasets.
5. Uses glmnet to identify the important markers for each cluster and trains an SVM model for classification.
6. Predicts the cluster for test samples and provides probabilities for each cluster.
}
\examples{
cluster.data <- data.frame(
  Sample = paste0("Sample", 1:60),
  Cluster = rep(paste0("C", 1:3), each = 20)
)
data.train <- matrix(rnorm(6000),
  nrow = 100,
  dimnames = list(paste0("Gene", 1:100), cluster.data$Sample)
)
data.test <- matrix(rnorm(5000),
  nrow = 100,
  dimnames = list(paste0("Gene", 1:100), paste0("P", 1:50))
)
cluster.markers <- setNames(
  lapply(
    unique(cluster.data$Cluster),
    function(cluster) {
      data.frame(Gene = sample(rownames(data.train), 10))
    }
  ),
  unique(cluster.data$Cluster)
)
result <- Classifier.SVM(
  data.test = data.test, data.train = data.train,
  cluster.data, cluster.markers
)
head(result)

}
\author{
Zaoqu Liu; Email: liuzaoqu@163.com
}

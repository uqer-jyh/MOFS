% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RunCOCA.R
\name{RunCOCA}
\alias{RunCOCA}
\title{Run Consensus Clustering Analysis (COCA)}
\usage{
RunCOCA(
  jaccard.matrix,
  max.clusters = 6,
  optimal.clusters = 3,
  linkage.method = "ward.D2",
  clustering.algorithm = "hc",
  distance.metric = "euclidean",
  resampling.iterations = 10000,
  resample.proportion = 0.7
)
}
\arguments{
\item{jaccard.matrix}{A Jaccard distance matrix, typically obtained from binary data.}

\item{max.clusters}{Integer. The maximum number of clusters to evaluate (default: 6).}

\item{optimal.clusters}{Integer. The optimal number of clusters to select (default: 3).}

\item{linkage.method}{Character. The linkage method for hierarchical clustering (default: "ward.D2").}

\item{clustering.algorithm}{Character. The clustering algorithm to use (default: 'hc').}

\item{distance.metric}{Character. The distance metric to use (default: "euclidean").}

\item{resampling.iterations}{Integer. The number of resampling iterations (default: 10000).}

\item{resample.proportion}{Numeric. Proportion of items to resample in each iteration (default: 0.7).}
}
\value{
A list containing the consensus clustering results, optimal cluster solution, PAC values, and final cluster assignments.
}
\description{
This function performs Consensus Clustering Analysis (COCA) using the ConsensusClusterPlus package to identify stable clusters in the input data.
}
\details{
This function uses ConsensusClusterPlus to perform consensus clustering on the input Jaccard distance matrix, evaluates the stability of different clustering solutions using PAC, and returns the clustering assignments.
}
\examples{
# Example usage:
jaccard_matrix <- CalJaccardDistance(data)
coca_result <- RunCOCA(jaccard.matrix = jaccard_matrix, max.clusters = 6, optimal.clusters = 3)

}
\author{
Zaoqu Liu; Email: liuzaoqu@163.com
}

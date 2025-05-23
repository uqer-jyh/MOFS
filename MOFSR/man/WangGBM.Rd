% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/WangGBM.R
\name{WangGBM}
\alias{WangGBM}
\title{Perform ssGSEA-based Subtyping for GBM Samples}
\usage{
WangGBM(
  data.test,
  dir.file = ".",
  gct.filename = "data.gct",
  number.perms = 10,
  tolerate.mixed = FALSE
)
}
\arguments{
\item{data.test}{A matrix or data frame representing the input expression data, where rows are genes and columns are samples.}

\item{dir.file}{Character. Directory for saving the output files (default: '.').}

\item{gct.filename}{Character. The filename for the generated GCT file (default: 'data.gct').}

\item{number.perms}{Integer. Number of permutations for ssGSEA analysis (default: 10).}

\item{tolerate.mixed}{Logical. Whether to allow "Mixed" predictions when multiple gene sets have the same minimum p-value (default: FALSE).}
}
\value{
A data frame with the following columns:
  - `ID`: Sample identifiers.
  - `Predict`: Predicted subtype for each sample.
  - Columns with `_pval`: P-values for each subtype or marker gene set.
}
\description{
This function runs single-sample Gene Set Enrichment Analysis (ssGSEA) for Glioblastoma Multiforme (GBM) data, predicts sample subtypes based on enrichment scores, and identifies the most likely subtype using marker gene sets.
}
\details{
The function:
  1. Converts the input expression data into a GCT file format for ssGSEA analysis.
  2. Runs ssGSEA using the `ssgsea.GBM.classification` package, which calculates enrichment scores.
  3. Reads the p-value results generated by ssGSEA and predicts subtypes for each sample based on the most significant enrichment (smallest p-value).
  4. If `tolerate.mixed` is TRUE and multiple subtypes have the same minimum p-value, the sample is labeled as "Mixed".
}
\examples{
# Simulated expression data
data.test <- matrix(rnorm(10000), nrow = 100, ncol = 100)
rownames(data.test) <- paste0("Gene", 1:100)
colnames(data.test) <- paste0("Sample", 1:100)

# Run GBM ssGSEA-based subtyping
result <- WangGBM(
  data.test = data.test,
  dir.file = "./results",
  gct.filename = "test_data.gct",
  tolerate.mixed = TRUE
)
print(result)
}
\references{
Wang Q, Hu B, Hu X, Kim H, Squatrito M, Scarpace L, et al. Tumor Evolution of Glioma-Intrinsic Gene Expression Subtypes Associates with Immunological Changes in the Microenvironment. Cancer Cell. July 2017;32(1):42-56.e6.
}
\author{
Zaoqu Liu; Email: liuzaoqu@163.com
}

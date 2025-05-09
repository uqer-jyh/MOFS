% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/init.R
\name{init}
\alias{init}
\title{MOFSR Environment Initialization}
\usage{
init()
}
\arguments{
\item{force}{A logical value. If `TRUE`, the function will force reinstallation of the specified GitHub packages (`genekitr2`, `pathview`, and `GSReg`) regardless of whether they are already installed or not. Default is `TRUE`.}
}
\value{
This function does not return any value. It performs the installation of required packages and outputs messages to indicate the status of the installation process.
}
\description{
This function sets up the required environment for the MOFSR package by checking and installing the necessary R packages. It also ensures that specific GitHub packages are installed with the correct versions using the `force = TRUE` option.
}
\details{
This function is designed to configure the environment for MOFSR by ensuring the installation of a wide range of R packages that are dependencies for the package. In addition to standard CRAN packages, specific packages hosted on GitHub (`genekitr2`, `pathview`, and `GSReg`) are reinstalled to guarantee that the correct versions are used.
}
\examples{
# Run the init function to set up the MOFSR environment
init()

}
\author{
Zaoqu Liu; E-mail: liuzaoqu@163.com
}

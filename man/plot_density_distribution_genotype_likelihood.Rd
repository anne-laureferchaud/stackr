% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/visualization.R
\name{plot_density_distribution_genotype_likelihood}
\alias{plot_density_distribution_genotype_likelihood}
\title{Figure density distribution of genotype likelihood summary statistics}
\usage{
plot_density_distribution_genotype_likelihood(data, aes.colour, adjust.bin)
}
\arguments{
\item{data}{Genotype likelihood summary file.}

\item{aes.colour}{GGPLOT2 aesthetics colour,
e.g. aes(y = ..scaled.., color = GENOTYPE_LIKELIHOOD_GROUP).}

\item{adjust.bin}{Adjust GGPLOT2 bin size (0 to 1).}
}
\description{
Create density distribution of genotype likelihood
summary statistics.
Use the long version of coverage summary file created with
genotype_likelihood_summary function ($gl.summary.long).
}
\seealso{
\link{summary_genotype_likelihood}
}


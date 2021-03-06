% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/filter_fis.R
\name{filter_fis}
\alias{filter_fis}
\title{Fis filter}
\usage{
filter_fis(data, fis.min.threshold, fis.max.threshold, fis.diff.threshold,
  pop.threshold, percent, filename)
}
\arguments{
\item{data}{A data frame object or file (using ".tsv")
of class sumstats or a tidy VCF summarised.}

\item{fis.min.threshold}{Number}

\item{fis.max.threshold}{Number.}

\item{fis.diff.threshold}{Number (0 - 1)}

\item{pop.threshold}{Fixed number of pop required to keep the locus.}

\item{percent}{Is the threshold a percentage ? TRUE or FALSE.}

\item{filename}{Name of the file written to the working directory (optional).}
}
\description{
Inbreeding coefficient filter from a sumstats prepared file
or a tidy VCF file.
}


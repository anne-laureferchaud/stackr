% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/whitelist_blacklist.R
\name{blacklist_loci}
\alias{blacklist_loci}
\title{Blacklist loci}
\usage{
blacklist_loci(before.filter.data, after.filter.data, filename, col.header)
}
\arguments{
\item{before.filter.data}{A tidy vcf or sumstats prep file (using ".tsv")
or object in your Environment. Before the filter you want to test.}

\item{after.filter.data}{A tidy vcf or sumstats prep file (using ".tsv")
or object in your Environment, after the filter you want to test.}

\item{filename}{The name of the file written in the directory.}

\item{col.header}{TRUE and the loci will have a column header 'LOCUS'.}
}
\description{
This function creates a blacklist of loci, used after applying a filter
to keep track of the loci removed by a filter.
}
\author{
Thierry Gosselin \email{thierrygosselin@icloud.com}
}


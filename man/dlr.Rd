% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/dlr.R
\name{dlr}
\alias{dlr}
\title{Genotype likelihood ratio distance (Dlr)}
\usage{
dlr(assignment, l.skip, number.individuals, number.pop, pop.id.start,
  pop.id.end, sites.levels, pop.labels, pop.levels, filename)
}
\arguments{
\item{assignment}{The output assignment file (home likelihood or
likelihood ratio statistics) from GENODIVE.}

\item{l.skip}{The number of lines to skip before the individuals info
in GenoDive assignment results.}

\item{number.individuals}{The number of individuals analysed.}

\item{number.pop}{The number of populations analysed.}

\item{pop.id.start}{The start of your population id
in the name of your individual sample.}

\item{pop.id.end}{The end of your population id
in the name of your individual sample.}

\item{sites.levels}{An optional character string with your sites names in
the same order as the pop levels below.}

\item{pop.labels}{The pop label to identify your sampling sites. Use the same
string as sites.levels if you are conducted the assignment test on sampling
sites that differ in naming with your populations.}

\item{pop.levels}{An optional character string with your populations ordered.}

\item{filename}{(optional) Name of the file prefix for
the matrix and the table written in the working directory.}
}
\value{
A list with 3 objects of class: table ($dlr.table), dist (a lower
diagonal matrix, $dlr.dist), data.frame (a mirrored matrix, $dlr.matrix).
}
\description{
The function computes Paetkau's et al. (1997) genotype likelihood
ratio distance (Dlr).
}
\author{
Thierry Gosselin \email{thierrygosselin@icloud.com}
}
\references{
Paetkau D, Slade R, Burden M, Estoup A (2004)
Genetic assignment methods for the direct, real-time estimation of
migration rate: a simulation-based exploration of accuracy and power.
Molecular Ecology, 13, 55-65.

Paetkau D, Waits LP, Clarkson PL, Craighead L, Strobeck C (1997)
 An empirical evaluation of genetic distance statistics using microsatellite
  data from bear (Ursidae) populations. Genetics, 147, 1943-1957.

Meirmans PG, Van Tienderen PH (2004) genotype and genodive:
two programs for the analysis of genetic diversity of asexual organisms.
Molecular Ecology Notes, 4, 792-794.
}


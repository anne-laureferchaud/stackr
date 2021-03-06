% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/haplo2genepop.R
\name{haplo2genepop}
\alias{haplo2genepop}
\title{Use the batch_x.haplotypes.tsv file to write a genpop file.}
\usage{
haplo2genepop(haplotypes.file, whitelist.loci = NULL, blacklist.id = NULL,
  genepop.filename = "genepop.gen", genepop.header = "my first genepop",
  pop.levels, pop.id.start, pop.id.end, imputations = FALSE,
  imputations.group = "populations", num.tree = 100, iteration.rf = 10,
  split.number = 100, verbose = FALSE, parallel.core = 2)
}
\arguments{
\item{haplotypes.file}{The 'batch_x.haplotypes.tsv' created by STACKS.}

\item{whitelist.loci}{(optional) A whitelist of loci and
a column header 'LOCUS'.
The whitelist is in the directory (e.g. "whitelist.txt").}

\item{blacklist.id}{(optional) A blacklist with individual ID and
a column header 'INDIVIDUALS'. The blacklist is in the directory
 (e.g. "blacklist.txt").}

\item{genepop.filename}{The name of the file written to the directory.
Use the extension ".gen" at the end. Default \code{genepop.gen}.}

\item{genepop.header}{The first line of the Genepop file.
Default \code{my firt genepop}.}

\item{pop.levels}{An optional character string with your populations ordered.}

\item{pop.id.start}{The start of your population id
in the name of your individual sample.}

\item{pop.id.end}{The end of your population id
in the name of your individual sample.}

\item{imputations}{Should a map-independent imputations of markers be
computed. Available choices are: (1) \code{FALSE} for no imputation.
(2) \code{"max"} to use the most frequent category for imputations.
 (3) \code{"rf"} using Random Forest algorithm. Default = \code{FALSE}.}

\item{imputations.group}{\code{"global"} or \code{"populations"}.
Should the imputations be computed globally or by populations. If you choose
global, turn the verbose to \code{TRUE}, to see progress.
Default = \code{"populations"}.}

\item{num.tree}{The number of trees to grow in Random Forest. Default is 100.}

\item{iteration.rf}{The number of iterations of missing data algorithm
in Random Forest. Default is 10.}

\item{split.number}{Non-negative integer value used to specify
random splitting in Random Forest. Default is 100.}

\item{verbose}{Logical. Should trace output be enabled on each iteration
in Random Forest ? Default is \code{FALSE}.}

\item{parallel.core}{(optional) The number of core for OpenMP shared-memory parallel
programming of Random Forest imputations. For more info on how to install the
OpenMP version see \code{\link[randomForestSRC]{randomForestSRC-package}}.
If not selected \code{detectCores()-1} is used as default.}
}
\value{
When no imputation is selected a genepop file is saved to the
working directory. When imputation is selected 2 genepop files are saved to
the working directory.
}
\description{
This function can first filter the haplotypes file
with a whitelist of loci and a blacklist of individuals.
Map-independent imputation using Random Forest or the most frequent category
is also available as an option.
}
\details{
The imputations using Random Forest requires more time to compute and can take several
minutes and hours depending on the size of the dataset and polymorphism of
the species used. e.g. with a low polymorphic taxa, and a data set
containing 30\% missing data, 5 000 haplotypes loci and 500 individuals
will require 15 min.
}
\author{
Thierry Gosselin \email{thierrygosselin@icloud.com}
}
\references{
Rousset F (2008) genepop’007: a complete re-implementation
of the genepop software for Windows and Linux.
Molecular Ecology Resources, 8, 103-106.

Catchen JM, Amores A, Hohenlohe PA et al. (2011)
Stacks: Building and Genotyping Loci De Novo From Short-Read Sequences.
G3, 1, 171-182.

Catchen JM, Hohenlohe PA, Bassham S, Amores A, Cresko WA (2013)
Stacks: an analysis tool set for population genomics.
Molecular Ecology, 22, 3124-3140.

Ishwaran H. and Kogalur U.B. (2015). Random Forests for Survival,
 Regression and Classification (RF-SRC), R package version 1.6.1.

Ishwaran H. and Kogalur U.B. (2007). Random survival forests
for R. R News 7(2), 25-31.

Ishwaran H., Kogalur U.B., Blackstone E.H. and Lauer M.S. (2008).
Random survival forests. Ann. Appl. Statist. 2(3), 841--860.
}


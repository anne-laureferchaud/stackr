% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/summary.R
\name{table_low_coverage_summary}
\alias{table_low_coverage_summary}
\title{Table of low coverage genotypes}
\usage{
table_low_coverage_summary(tidy.vcf.file, pop.levels, read.depth.threshold,
  filename.low.coverage, filename.low.coverage.imbalance)
}
\arguments{
\item{tidy.vcf.file}{The tidy VCF file created with read_stacks_vcf.}

\item{pop.levels}{Character string defining your ordered populations.}

\item{read.depth.threshold}{The read depth threshold to evaluate.}

\item{filename.low.coverage}{Filename of the low coverage table written
in the working directory.}

\item{filename.low.coverage.imbalance}{Filename of ...}
}
\value{
a list of 2 tables (accessed with $). The values in the tables
represent percentage of samples.
}
\description{
This function create a table summary of the genotypes
below a user-define threshold.
coverage statistics by populations.
}
\details{
work in progress....
Table 1: low coverage summary $low.coverage.summary (homo- and
hetero- zygotes genotypes).
Table 2: summary of coverage imbalance between alleles in the heterozygotes.
0/0 : homozygote REF allele.
1/1 : homozygote ALT allele.
0/1 : heterozygote with coverage REF > ALT allele.
1/0 : heterozygote with coverage REF < ALT allele.
}


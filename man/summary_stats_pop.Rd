% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/summary.R
\name{summary_stats_pop}
\alias{summary_stats_pop}
\title{Summary statistics of a tidy VCF by population}
\usage{
summary_stats_pop(data, filename)
}
\arguments{
\item{data}{The tidy VCF file created with read_stacks_vcf.}

\item{filename}{(optional) Name of the file written to the working directory.}
}
\description{
Summarise the tidy VCF.
The populations summary on :  frequency of the REF
and the ALT alleles, the observed and the expected heterozygosity
and the inbreeding coefficient. The Global MAF of Loci,
with STACKS GBS/RAD loci = read or de novo haplotypes,
is included and repeated over SNP.
}


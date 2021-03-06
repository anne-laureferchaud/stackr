% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/whitelist_blacklist.R
\name{whitelist_loci_vcf}
\alias{whitelist_loci_vcf}
\title{Whitelist loci for VCF tools}
\usage{
whitelist_loci_vcf(data, filename)
}
\arguments{
\item{data}{A tidy vcf or sumstats prep file (using ".tsv") or object in
your Environment.}

\item{filename}{The name of the file written in the directory.}
}
\description{
This function creates a whitelist of loci for VCF tools.
With 2 columns (CHROM and ID).
}
\author{
Thierry Gosselin \email{thierrygosselin@icloud.com}
}
\seealso{
\link{read_stacks_vcf} and  \link{summary_stats_vcf_tidy}
}


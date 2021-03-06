% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/read_stacks_haplotypes_vcf.R
\name{read_stacks_haplotypes_vcf}
\alias{read_stacks_haplotypes_vcf}
\title{Make a tidy format of the batch_x.haplotypes.vcf file}
\usage{
read_stacks_haplotypes_vcf(haplotypes.vcf.file, pop.id.start, pop.id.end,
  pop.levels, filter, filename)
}
\arguments{
\item{haplotypes.vcf.file}{The haplotypes VCF file.}

\item{pop.id.start}{The start of your population id
in the name of your individual sample.}

\item{pop.id.end}{The end of your population id
in the name of your individual sample.}

\item{pop.levels}{An optional character string with your populations ordered.}

\item{filter}{An optional filter of loci can be applied
to the haplotypes VCF, using a file in the working directory
 (e.g. "myfile.txt") or an object in the global environment.
 Highly recommended to reduce the resulting file size.}

\item{filename}{The name of the file written in the directory.}
}
\description{
Import and transform in tidy format the batch_x.haplotypes.vcf
file produced by STACKS.
}


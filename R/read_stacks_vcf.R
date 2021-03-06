#' @title Read a VCF file produced by STACKS and transform in tidy format
#' @description Import a VCF file created by STACKS and mofify to a tidy format.
#' @param vcf.file The VCF file created by STACKS.
#' @param pop.id.start The start of your population id 
#' in the name of your individual sample.
#' @param pop.id.end The end of your population id 
#' in the name of your individual sample.
#' @param pop.levels An optional character string with your populations ordered.
#' @param whitelist An optional filter of loci can be applied to the vcf, using
#' a file in the working directory (e.g. "myfile.txt") or an object
#' in the global environment.
#' @param blacklist (optional) Blacklist file with loci to filter out
#' of the vcf, using a file in the working directory (e.g. "myfile.txt")
#' or an object in the global environment.
#' @param filename (optional) The name of the file written in the directory.
#' @rdname read_stacks_vcf
#' @export
#' @import dplyr
#' @import readr
#' @details Your individuals are identified in this form : 
#' CHI-QUE-ADU-2014-020, (SPE-POP-MAT-YEA-ID). Then, \code{pop.id.start} = 5
#' and \code{pop.id.end} = 7. With 5 populations: ALK, JAP, NOR, QUE, LAB, 
#' the \code{pop.levels} option could look like this: 
#' c("JAP", "ALK", "QUE", "LAB", "NOR"). Useful for hierarchical clustering.
#' @examples
#' \dontrun{
#' vcf.tidy <- read_stacks_vcf(
#' vcf.file = "batch_1.vcf", 
#' pop.id.start = 5, 
#' pop.id.end = 7, 
#' pop.levels = c("JAP", "ALK", "QUE", "LAB", "NOR"), 
#' whitelist = "whitelist.loci.txt", 
#' blacklist = "blacklist.loci.paralogs.txt", 
#' filename = "vcf.tidy.paralogs.tsv")
#' }
#' @references Danecek P, Auton A, Abecasis G et al. (2011)
#' The variant call format and VCFtools.
#' Bioinformatics, 27, 2156-2158.
#' @references Catchen JM, Amores A, Hohenlohe PA et al. (2011) 
#' Stacks: Building and Genotyping Loci De Novo From Short-Read Sequences. 
#' G3, 1, 171-182.
#' @references Catchen JM, Hohenlohe PA, Bassham S, Amores A, Cresko WA (2013) 
#' Stacks: an analysis tool set for population genomics. 
#' Molecular Ecology, 22, 3124-3140.
#' @author Thierry Gosselin \email{thierrygosselin@@icloud.com}


read_stacks_vcf <- function(vcf.file, pop.id.start, pop.id.end, pop.levels, whitelist, blacklist, filename) {
  
  X1 <- NULL
  POP_ID <- NULL
  QUAL <- NULL
  FILTER <- NULL
  FORMAT <- NULL
  ID <- NULL
  `#CHROM` <- NULL
  INFO <- NULL
  N <- NULL
  AF <- NULL
  INDIVIDUALS <- NULL
  REF <- NULL
  ALT <- NULL
  READ_DEPTH <- NULL
  REF_FREQ <- NULL
  ALT_FREQ <- NULL
  ALLELE_DEPTH <- NULL
  GT <- NULL
  GL <- NULL
  #   ALLELE_P <- NULL
  #   ALLELE_Q <- NULL
  ALLELE_REF_DEPTH <- NULL
  ALLELE_ALT_DEPTH <- NULL
  
  # Import/read VCF ------------------------------------------------------------- 
  message("Importing the VCF...")
  
  vcf <- read_delim(
    vcf.file, delim = "\t", 
    skip = 9,#n_max = max.read.lines,
    progress = interactive()
  ) %>% 
    select(-c(QUAL, FILTER, FORMAT)) %>%
    rename(LOCUS = ID, CHROM = `#CHROM`)
  
  # Whitelist/Blacklist ---------------------------------------------------------- 
  if (missing(whitelist) == "TRUE") {
    vcf <- vcf
    message("No whitelist to apply to the VCF")
    
  } else if (is.vector(whitelist) == "TRUE") {
    vcf <- vcf %>% 
      semi_join(
        read_tsv(whitelist, col_names = T),
        by = "LOCUS"
        )
    message("Filtering the VCF with the whitelist from your directory")
    
  } else {
    vcf <- vcf %>%
      semi_join(whitelist, by = "LOCUS")
    message("Filtering the VCF with the whitelist from your global environment")
    
  }
  
  if (missing(blacklist) == "TRUE") {
    vcf <- vcf
    message("No blacklist to apply to the VCF")
    
  } else if (is.vector(blacklist) == "TRUE") {
    message("Filtering the VCF with the blacklist from your directory")
    
    vcf <- vcf  %>% 
      anti_join(
        read_tsv(blacklist, col_names = T),
        by = "LOCUS"
      )
    
  } else {
    message("Filtering the VCF with the blacklist from your global environment")
    
    vcf <- vcf %>% 
      anti_join(blacklist, by = "LOCUS")
    
  }
  
  # Make VCF tidy-----------------------------------------------------------------
  vcf <- vcf %>%
    separate(INFO, c("N", "AF"), sep = ";", extra = "error") %>%
    mutate(
      N = as.numeric(stri_replace_all_fixed(N, "NS=", "", vectorize_all=F)),
      AF = stri_replace_all_fixed(AF, "AF=", "", vectorize_all=F)
    ) %>%
    separate(AF, c("REF_FREQ", "ALT_FREQ"), sep = ",", extra = "error") %>%
    mutate(
      REF_FREQ = as.numeric(REF_FREQ),
      ALT_FREQ = as.numeric(ALT_FREQ)
    )
  # Gather individuals in 1 colummn --------------------------------------------
  vcf <- gather(vcf, INDIVIDUALS, FORMAT, -c(CHROM:ALT_FREQ))
  
  message("Gathering individuals in 1 column")
  
  # Separate FORMAT and COVERAGE columns ---------------------------------------
  message("Tidying the VCF...")
  
  vcf <- vcf %>%
    separate(FORMAT, c("GT", "READ_DEPTH", "ALLELE_DEPTH", "GL"),
             sep = ":", extra = "error") %>%
    #   separate(GT, c("ALLELE_P", "ALLELE_Q"), 
    #            sep = "/", extra = "error", remove = F) %>%
    separate(ALLELE_DEPTH, c("ALLELE_REF_DEPTH", "ALLELE_ALT_DEPTH"),
             sep = ",", extra = "error")
  
  # Work with Mutate on CHROM and GL -------------------------------------------
  message("Fixing columns...")
  
  vcf <- vcf %>%
    mutate(
      CHROM = suppressWarnings(as.numeric(stri_replace_all_fixed(CHROM, "un", "1", vectorize_all=F))),
      GL = suppressWarnings(as.numeric(stri_replace_all_fixed(GL, c(".,.,.", ".,", ",."), c("NA", "", ""), vectorize_all=F)))
    ) %>%
    # Work with Mutate on ALLELE_P and ALLELE_Q
    # vcf <- vcf %>% 
    #   mutate(
    #     ALLELE_P = ifelse (ALLELE_P == ".", "NA",
    #                        ifelse(ALLELE_P == "0", REF, ALT)),
    #     ALLELE_Q = ifelse (ALLELE_Q == ".", "NA",
    #                        ifelse(ALLELE_Q == "0", REF, ALT))
    #   )
    # Mutate read and alleles REF/ALT depth
    mutate(READ_DEPTH = suppressWarnings(as.numeric(stri_replace_all_regex(READ_DEPTH, "^0$", "NA", vectorize_all=F))),
           ALLELE_REF_DEPTH = suppressWarnings(as.numeric(stri_replace_all_regex(ALLELE_REF_DEPTH, "^0$", "NA", vectorize_all = TRUE))),
           ALLELE_ALT_DEPTH = suppressWarnings(as.numeric(stri_replace_all_regex(ALLELE_ALT_DEPTH, "^0$", "NA", vectorize_all = TRUE))),
           # Mutate coverage ration for allelic imbalance
           ALLELE_COVERAGE_RATIO = suppressWarnings(
             as.numeric(ifelse(GT == "./." | GT == "0/0" | GT == "1/1", "NA",
                               ((ALLELE_ALT_DEPTH - ALLELE_REF_DEPTH)/(ALLELE_ALT_DEPTH + ALLELE_REF_DEPTH)))))
    )
  # Populations levels ---------------------------------------------------------
  message("Adding a population column ...")
  
  vcf <- mutate(
    vcf, 
    POP_ID = factor(str_sub(INDIVIDUALS, pop.id.start, pop.id.end),
                    levels = pop.levels, ordered =T)
  ) %>%
    arrange(LOCUS, POS, POP_ID, INDIVIDUALS)  
  
  # Reorder the columns --------------------------------------------------------
  message("Reordering columns ...")
  # vcf <- vcf[c("CHROM", "LOCUS", "POS", "N", "REF", "ALT", "REF_FREQ", "ALT_FREQ", "POP_ID", "INDIVIDUALS", "GT", "ALLELE_P", "ALLELE_Q", "READ_DEPTH", "ALLELE_REF_DEPTH", "ALLELE_ALT_DEPTH", "ALLELE_COVERAGE_RATIO", "GL")]
  vcf <- vcf[c("CHROM", "LOCUS", "POS", "N", "REF", "ALT", "REF_FREQ", "ALT_FREQ", "POP_ID", "INDIVIDUALS", "GT", "READ_DEPTH", "ALLELE_REF_DEPTH", "ALLELE_ALT_DEPTH", "ALLELE_COVERAGE_RATIO", "GL")]
  
  
  # Save/Write the file to the working directory--------------------------------
  if (missing(filename) == "FALSE") {
    message("Saving the file in your working directory, may take some time...")
    write_tsv(vcf, filename, append = FALSE, col_names = TRUE)
    saving <- paste("Saving was selected, the filename:", filename, sep = " ")
  } else {
    saving <- "Saving was not selected..."
  }
  
  # Message at the end ---------------------------------------------------------- 
  invisible(cat(sprintf(
    "%s\n
Working directory:
%s",
    saving, getwd()
  )))
  vcf
}



# PLINK tools

# In ADMIXTURE to do bootstrap you need a tfam file,
# the one in STACKS is not as good...

make_tfam <- function(population.map, pop.id.start, pop.id.end, pop.levels, filename) {
    
  if (is.vector(population.map) == "TRUE") {
    population.map <- read_tsv(population.map, col_names = F)
  } else {
    population.map <- population.map
  }
 
  tfam <- population.map %>%
    select(INDIVIDUALS=X1) %>%
    mutate(
      INDIVIDUALS = as.character(INDIVIDUALS),
      POP_ID = str_sub(INDIVIDUALS, pop.id.start, pop.id.end),
      POP_ID = factor(POP_ID, levels = pop.levels, ordered =T)
      ) %>%
    select(POP_ID, INDIVIDUALS) %>%
    arrange(POP_ID, INDIVIDUALS) %>%
    mutate(
      COL1 = rep("0",n()),
      COL2 = rep("0",n()),
      COL3 = rep("0",n()),
      COL4 = rep("0",n())
      )

  write.table(tfam, filename, sep = "\t", row.names = F, col.names = F, quote = F)

  invisible(cat(sprintf(
  "tfam filename:
  %s\n
  Written in the directory:
  %s",
  filename, getwd()
  )))
}
#!/usr/bin/env Rscript
library(readr)

MultiplyComponent <- function(item) 
{
  open_bracket <- which(strsplit(item, "")[[1]] == "(")
  close_bracket <- which(strsplit(item, "")[[1]] == ")")
  print(paste("Processing:", item))
  if (open_bracket == 1 && close_bracket <= 9) 
  {
    enclosed <- substring(item, open_bracket[1] + 1, close_bracket[1] - 1)
    print(paste("Extracted:", enclosed))
    numbers <- as.numeric(strsplit(enclosed, ",")[[1]])
    if (length(numbers) == 2) 
    {
      product <- prod(numbers)
      print(paste("Product:", product))
      return(product)
    }
  } 
  return(NA_real_)
}


backpack <- read_file("test.txt")
instruction <- "mul"

multipliable <- strsplit(backpack, instruction, fixed=TRUE)[[1]]
multipliable <- multipliable[grep(")", multipliable, fixed=TRUE)]

results <- sapply(multipliable, MultiplyComponent, simplify=TRUE)
results <- results[!is.na(results)]
total <- sum(results)

print(results)
print(total)

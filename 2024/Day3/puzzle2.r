#!/usr/bin/env Rscript
library(readr)

MultiplyComponent <- function(item) 
{
  open_bracket <- which(strsplit(item, "")[[1]] == "(")
  close_bracket <- which(strsplit(item, "")[[1]] == ")")
  print(paste("Processing:", item))
  print(open_bracket)
  print(close_bracket)
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


muliply <- function(input) 
{
  instruction <- "mul"
  multipliable <- strsplit(input, instruction, fixed=TRUE)[[1]]
  multipliable <- multipliable[grep(")", multipliable, fixed=TRUE)]

  results <- sapply(multipliable, MultiplyComponent, simplify=TRUE)
  results <- results[!is.na(results)]
  total <- sum(results)
  return(total)
}

not_multiply <- function(input) 
{
  instruction <- "don't()"
  false_multipliable <- strsplit(input, instruction, fixed=TRUE)[[1]]
  mul <- c()

  for (i in false_multipliable) 
  {
    occ <- unlist(gregexpr('do()', i))[1]
    if (occ != -1) i <- substr(i, 1, occ - 1)
    mul_segments <- strsplit(i, "mul", fixed=TRUE)[[1]]
    mul <- c(mul, mul_segments)
  }
  results <- sapply(mul, MultiplyComponent, simplify=TRUE)
  results <- results[!is.na(results)]
  total <- sum(results)
  return(total)
}

backpack <- read_file("input.txt")

b <- not_multiply(backpack)
a <- muliply(backpack)

print(a)
print(b)

total <- a - b
print(total)
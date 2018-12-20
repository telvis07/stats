# Chapter 3: Random Variables and Their Distributions

chap_3_main <- function() {
  # stats chapter 3. pbinom
  
  # Prob x=3 where X ~ Bin(5, 0.2)
  p <- dbinom(3, 5, 0.2)
  print(paste("dbinom(3, 5, 0.2)", p, sep = " "))
  
  # Prob x<3 where X ~ Bin(5, 0.2)
  p <- pbinom(3, 5, 0.2)
  print(paste("dbinom(3, 5, 0.2)", p, sep=" "))
  
  # Prob x=2 where X ~ HyperGeom(4, 48, 5)
  # probability of getting 2 aces
  # from a deck with 4 aces and 48 non aces
  # in a 5 card hand
  p <- dhyper(2, 4, 48, 5)
  print(paste("dhyper(2, 4, 48, 5)", p, sep= " "))
  
  
  # uniform sampling
  # sample 5 from uniform(1, 100)
  p <- sample(100, 5, replace=TRUE)
  p <- paste(p, collapse=",")
  print(paste("sample(100, 5, replace=T)", p, sep = " "))
  
  # P(X_j = 0) = 0.25
  # P(X_j = 1) = 0.50
  # P(X_j = 5) = 0.10
  # P(X_j = 10) = 0.15
  x <- c(0, 1, 5, 10)
  p <- c(0.25, 0.5, 0.1, 0.15)
  x_p <- sample(x, 100, prob=p, replace=TRUE)
  x_p <- paste(x_p, collapse=",")
  print(x_p)
}
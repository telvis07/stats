# install.packages("mvtnorm")
library(mvtnorm)

chap7.1 <- function() {
  # returns the probability 
  # P(X_1, X_2, X_3) ~ Mult_3(5, (1/3, 1/3, 1/3))
  
  x <- c(2, 0, 3)
  
  # Of course, n has to equal sum(x)
  n <- 5
  p <- c(1/3, 1/3, 1/3)
  dmultinom(x, n, p)
}

chap7.2 <- function() {
  # for rmultinom(), the first number is the number of Multinomial random vectors
  # to generate, and the other inputs are the same.
  
  x <- c(2, 0, 3)
  
  # Of course, n has to equal sum(x)
  n <- 5
  p <- c(1/3, 1/3, 1/3)
  
  # Each column of the matrix corresponds to a draw from the  Mult_3(5, (1/3, 1/3, 1/3))
  # distribution. In particular, the num of each column is 5.
  rmultinom(10, n, p)
}


chap7.3 <- function() {
  # dvmnorm can be used for calculating the joing PDF and rmvnorm can be used for 
  # generating random vectors. For example, suppose that we want to generate 1000 independent
  # Bivariate Normal pairs(Z, W), with correlation p = 0.7 and Norm(0,1)
  meanvector <- c(0,0)
  rho <- 0.7
  covmatrix <- matrix(c(1, rho, rho, 1), nrow=2, ncol=2)
  r <- rmvnorm(n=10^3, mean=meanvector, sigma=covmatrix)
  
  # The covariance matrix is
  # [(1, rho), (rho, 1)]
  # because:
  # Cov(Z, Z) = Var(Z) = 1 (this is the upper left entry)
  # Cov(W, W) = Var(W) = 1 (this is the lower right entry)
  # Cov(Z, W) = Corr(Z,W) * sd(Z) * sd(W) = rho
  
  # now r  is 1000 x 2 matrix, with each row a BVN random vector. To see these as
  # in the plan, we can use plot(r) to make a scatter plot.
  plot(r)
}

chap7.4 <- function() {
  # This gives the Z-coordinates in a vector and the W-coordinates in a vector w.
  # If we want to put them into one 1000 x 2 matrix as we had above, we can type
  # cbind(z,w)
  
  rho <- 0.7
  tau <- sqrt(1-rho^2)
  x <- rnorm(10^3)
  y <- rnorm(10^3)
  z <- x
  
  # kind of like: y = C_1*x + C_2*y
  w <- rho*x + tau*y
  r <- cbind(z, w)
  
  # 
  plot(r)
}

chap7.5 <- function() {
  # heavy tail of the cauchy distribution
  hist(rcauchy(1000))
}






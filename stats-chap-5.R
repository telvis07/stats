# Continous Random Variables
# For continuous distributions, the function that starts with `d` is the PDF 
# instead of the PMR
library("ggplot2")

do_unif <- function() {
  # PDF
  x <- seq(-0.5, 1.5, 1/10000)
  y <- dunif(x, 0, 1)
  plot(x, y, type="l", xlab="x", ylab = "dunif(x)", main="Uniform Density PDF")
  # curve(dunif, from=-3, to=3, n=10000)
}

do_punif <- function() {
  # CDF
  x <- seq(0, 1, 1/1000)
  y <- punif(x, 0, 1)
  plot(x, y, type="l", main="Uniform Density CDF")
}

do_runif <- function() {
  # Randoms
  x <- runif(1000, 0, 1)
  hist(x)
}

do_dnorm <- function() {
  x <- seq(-3, 3, 0.01)
  y <- dnorm(x)
  datums <- data.frame(x=x, y=y)
  obj <- ggplot(datums, aes(x, y)) + geom_line() + labs(title="Normal Dist PDF")
  obj
}

do_pnorm <- function() {
  x <- seq(0, 1, 0.001)
  y <- pnorm(x)
  df <- data.frame(x=x, y=y)
  ggplot(df, aes(x=x, y=y)) + geom_line() + labs(title="Normal Dist CDF")
}

do_rnorm <- function() {
  df <- data.frame(x <- rnorm(1000))
  ggplot(df, aes(x=x)) + geom_histogram(bins=10)
  
}


library("ggplot2")


chap9.1 <- function() {
  # In example, 9.3.10, we derived formulas for the slope and intercept
  # of a linear regression model, which can be used to predict a response variable
  # using an explanatory variable. Let's try to apply these formulas
  # to a simulated dataset
  
  x <- rnorm(100)
  y <- 3 + 5*x + rnorm(100)
  
  # The vector x contains 100 norm(0,1)
  # y: contains 100 realizations of random variable Y = a + bX + eps
  # where eps = norm(0,1)
  # as we can see: the true values of a and b are 3 and 5, respectively
  df <- data.frame(x=x, y=y)
  p <- ggplot(df, aes(x=x, y=y)) + geom_line() + labs(title="regression example")
  print(p)
  
  # now let's see if we can get good estimates of the true a and b, using 
  # formulas in Example 9.3.10
  
  b <- cov(x,y) / var(x)
  a <- mean(y) - b*mean(x)
  
  # Here cov(x,y), var(x) and mean(x) provide the sample covariance, sample variance
  # and sample mean, estimating the quantities Cov(X,Y), Var(X) and E(X).
  
  # You should find that b is close to 5 and a is close to 3. These estimated values 
  # define the line of best fit. 
  
  df <- data.frame(x=x, y=y)
  p <- ggplot(df, aes(x=x, y=y)) + geom_line() + labs(title="regression example") + geom_abline(intercept = a, slope = b)
  print(p)
}
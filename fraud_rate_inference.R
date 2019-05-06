library(ggplot2)

fraudrate.sim <- function(p=0.086, nosim=1000, n=40) {
  q <- 1 - p
  
  # 1000 simulations
  # nosim <- 1000
  
  # num samples per simulation
  # n <- 40
  
  # calc the means
  mean.pop <- p
  
  # calc the variance
  var.pop <- p*q
  
  # Generate simulated data
  rbin_samples <- matrix(rbinom(n*nosim, 1, prob = p), nosim, n) 
  
  # Calc sample means for the 1000 simulations
  rbin_samples_means <- matrix(apply(rbin_samples, 1, mean))
  
  g = ggplot(data.frame(rbin_samples_means = rbin_samples_means), aes(x = rbin_samples_means))
  g = g + geom_histogram(color = "black", fill = "lightblue", binwidth = 0.05)
  g = g + geom_vline(size=2, xintercept = mean.pop)
  print(g)  
  
  print(sprintf("sample variance %0.6f", var(rbin_samples_means)))
  print(sprintf("theoretical variance: %0.6f", (p*q)/n))
  
  print(sprintf("sample mean %0.6f", mean(rbin_samples_means)))
  print(sprintf("theoretical variance: %0.6f", mean.pop))
  rbin_samples_means
}
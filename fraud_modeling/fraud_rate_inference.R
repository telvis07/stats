library(ggplot2)

fraudrate.sim <- function(p=0.1, nosim=2000, n=500) {
  # p
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
  
  # g = ggplot(data.frame(rbin_samples_means = rbin_samples_means), aes(x = rbin_samples_means)) +
  #     geom_histogram(color = "black", fill = "lightblue", bins = 50) +
  #     # geom_vline(size=2, xintercept = mean.pop) +
  #   theme(axis.title.x=element_blank(),
  #         # axis.text.x=element_blank(),
  #         axis.ticks.x=element_blank())
  
  # print(sprintf("sample variance %0.6f", var(rbin_samples_means)))
  # print(sprintf("theoretical variance: %0.6f", (p*q)/n))
  # 
  # print(sprintf("sample mean %0.6f", mean(rbin_samples_means)))
  # print(sprintf("theoretical variance: %0.6f", mean.pop))
  
  rbin_samples_means
  
}

fraudrate.sim.compare_plots <- function(){
  p1 <- fraudrate.sim(p=0.1, nosim=100, n=10)
  p2 <- fraudrate.sim(p=0.1, nosim=100, n=100)
  p3 <- fraudrate.sim(p=0.1, nosim=100, n=200)
  p4 <- fraudrate.sim(p=0.1, nosim=100, n=500)
  
  grid.arrange(p1, p2, p3, p4, nrow=1)
}

avgs_across_coin_flips <- function(nosim=100) {
  df <- data.frame(
    x = c(fraudrate.sim(p=0.1, nosim=nosim, n=10),
          fraudrate.sim(p=0.1, nosim=nosim, n=100),
          fraudrate.sim(p=0.1, nosim=nosim, n=200),
          fraudrate.sim(p=0.1, nosim=nosim, n=500)),
    size = factor(rep(c(10, 100, 200, 500), rep(nosim, 4)))
  )
  
  g <- ggplot(df, aes(x=x, fill=size)) +
       geom_histogram(alpha=0.20, bins=25, color="black") +
       facet_grid(. ~ size)    
  g
}

sample_variance_estimates <- function(p=0.1, nosim=100, n=10) {
  q <- 1 - p
  
  # calc the means
  mean.pop <- p
  
  # calc the variance
  var.pop <- p*q
  
  # Generate simulated data
  rbin_samples <- matrix(rbinom(n*nosim, 1, prob = p), nosim, n) 
  
  # Calc sample means for the 1000 simulations
  rbin_samples_means <- matrix(apply(rbin_samples, 1, mean))
  
  print(sprintf("sample variance %0.6f", var(rbin_samples_means)))
  print(sprintf("theoretical variance: %0.6f", (p*q)/n))

  print(sprintf("sample mean %0.6f", mean(rbin_samples_means)))
  print(sprintf("theoretical variance: %0.6f", mean.pop))
}




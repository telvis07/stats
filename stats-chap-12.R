chap12.1 <- function() {
  # Metropolis-Hastings 
  # Here's how to implement the Metropolis-Hastings algorithm for 
  # Example 12.1.8 the Normal-Normal model
  # First we choose our observed value of Y and decide on 
  # values for the constants sigma, mu and tau
  
  y <- 3
  sigma <- 1
  mu <- 0
  tau <- 2
  
  # We also need to choose the standard deviation of the proposals for 
  # step 1 of the algorithm, as explained in Example 12.1.8
  # For this problem, we let d=1. We set the number of iterations to run, and we
  # allocate a vector `theta` of length 10^4 which we will fill with out
  # simulated draws
  
  d <- 1
  niter <- 10^4
  theta <- rep(0, niter)
  
  # Now the main loop. We initialize theta to the observerd y, then run the algorithm
  # described in Example 12.1.8
  
  theta[1] <- y
  for (i in 2:niter) {
    # the proposed value of theta.p, which equals the previous value of theta
    # plus a normal random variable with mean 0 and standard deviation d 
    # (recall that rnorm takes the standard deviation and not variance as input)
    theta.p <- theta[i-1] + rnorm(1,0,d)
    
    # the ratio r: where theta.p is playing the role of x' and 
    # theta[i-1] is playing the role of x.
    r <- dnorm(y, theta.p, sigma) * dnorm(theta.p, mu, tau) / 
          (dnorm(y, theta[i-1], sigma) * dnorm(theta[i-1],mu,tau))
    
    # the coin flip to determine whether to accept or reject the proposal
    flip <- rbinom(1, 1, min(r, 1))
    
    # theta[i] is equal to the proposed value if the coin flip
    # lands on Heads, and we keep it at the previous value otherwise.
    theta[i] <- if(flip==1) theta.p else theta[i-1]
  }
  
  # the vector now contains all of our simulation draws. We typically discard
  # some of the intiial draws to give the chain some time to approach the 
  # stationary distribution. The following line of code discards the first half of the draws:
  
  theta <- theta[-(1:niter/2)]
  
  theta
}
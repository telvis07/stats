library(expm)

chap11.1 <- function(){
  # computing powers of a matix
  Q <- matrix(c(1/3, 1/3, 1/3, 0,
                0, 0, 1/2, 1/2,
                0, 1, 0, 0,
                1/2, 0, 0, 1/2), nrow=4, ncol=4, byrow=T)
  Q2 <- Q %*% Q
  Q3 <- Q2 %*% Q
  Q4 <- Q2 %*% Q2
  Q5 <- Q3 %*% Q2
  
  # if we want to know the probability of going from state 3 to state 4
  # in exactly 5 steps, we can extract the (3,4) entry of Q^5
  Q5[3,4]
  # should be : 11/48
}

chap11.2 <- function() {
  # compute powers of a matrix using `expm`
  Q5 <- Q %^% 5
  Q5[3,4]
}

chap11.3 <- function() {
  # computing powers of a matix
  Q <- matrix(c(1/3, 1/3, 1/3, 0,
                0, 0, 1/2, 1/2,
                0, 1, 0, 0,
                1/2, 0, 0, 1/2), nrow=4, ncol=4, byrow=T)
  
  # As N grows, each row converges to (0.214, 0.286, 0.214, 0.286)
  Q100 <- Q %^% 100
  Q100[1,]
  

  # # Another way to obtain the stationary distribution is to use
  # ret <- eigen(t(Q))
  # 
  # # TODO:
  # ret
}

chap11.4 <- function() {
  # computing powers of a matix
  Q <- matrix(c(1/3, 1/3, 1/3, 0,
                0, 0, 1/2, 1/2,
                0, 1, 0, 0,
                1/2, 0, 0, 1/2), nrow=4, ncol=4, byrow=T)
  
  
  # # Another way to obtain the stationary distribution is to
  # compute the eigenvalues and eigenvectors of the transpose of Q
  ret <- eigen(t(Q))

  # the eigenvector corresponding to teh eigenvalue 1 can be selected and normalized
  # so that the components sum to 1
  v <- ret$vector[,1]
  
  # 
  v / sum(v)
}

chap11.5  <- function() {
  # With a few modifications, we can simulate from an arbitrary Markov chain
  # on a finite state space. For concreteness, we will illustrate how to simulate
  # from the 4-state Markov chain in Example 11.1.5
  
  # transition matrix
  Q <- matrix(c(1/3, 1/3, 1/3, 0,
                0,0,1/2,1/2,
                0,1,0,0,
                1/2,0,0,1/2), nrow=4, ncol=4, byrow=T)
  
  # choose the number of states and the number of time
  # periods to simulate
  
  M <- nrow(Q)
  nsim <- 10^4
  x <- rep(0,nsim)
  x[1] <- sample(1:M,1)
  
  # for the simulation itself, we again use sample to choose a number
  # from 1 to M. At time i, the chain was previously at state x[i-1], so
  # must use row x[i-1] of the transition matrix to determine the probabilities
  # of sampling 1, 2, .... M. The notation Q[x[i-1],] denotes row x[i-1] of the matrix
  # Q.
  
  for ( i in 2:nsim) {
    x[i] <- sample(M, 1, prob=Q[x[i-1],])
  }
  
  # we then use the table command to calculate the number of times the chain visited 
  # each state; dividing by length(x) converts the counts to proportions.
  # The result is an approximation to the stationary distribution
  table(x) / length(x)
  
  # for comparison, the tru stationary distribution of the chain is
  # (3/14, 2/7, 3/14, 2/7) ~~ (0.214, 0.286, 0.214, 0.286)
  
}



library(expm)

chap9.1 <- function(){
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

chap9.2 <- function() {
  # compute powers of a matrix using `expm`
  Q5 <- Q %^% 5
  Q5[3,4]
}

chap9.3 <- function() {
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

chap9.4 <- function() {
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
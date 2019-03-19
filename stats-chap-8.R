library("ggplot2")


chap8.1 <- function() {
  # dbeta, pbeta, rbeta: 
  # To evaluate the Beta(a,b) PDF or CDF at x, we
  # use dbeta(x, a, b). To generate n realizations from the Beta(a,b)
  # distribution, we use rbeta(n, a, b)
  
  # pbeta
  # Think of 'a' as the number of prior successes and 'b' as the number of prior
  # failures in earlier experiments.
  # For concreteness, Figure 8.5 shows the case where the prior is Beta(1,1)
  # Equivalent to Unif(0,1). And we observe that n=5 coin tosses, all of which
  # land on HEADs. 
  
  # Start with 2 balls, 1 white, 1 gray. Throw the gray ball at the
  # 0.5 location on the unit interval [0,1]. What is the probability that a
  # randomly thrown white ball lasts to the left of the gray ball.
  pbeta(0.5, 1, 1) # we observe 1 coin flip and its HEADs
  
  # So we ask, given prior knowledge, what is the probability that 
  # 5 coin tosses will come up heads. Then the posterior is Beta(6, 1) 
  # distribution incorporates the evidence from the coin tosses
  
  # pg 353
  # Story 1: Start with (n coin tosses + 1): 7 balls, 6 white, 1 gray. Throw the gray ball at the
  # 0.5 location on the unit interval [0,1]. Let X be the number of white balls to the left of the
  # grey ball.
  
  # Story 2: Start with 7 balls, 6 white, 1 gray. Randomly throw each ball onto the 
  # unit interval; then choose one ball at random and paint it gray. Again, let X be the 
  # number of white balls to the left of the gray ball.
  
  
  pbeta(0.5, 6, 1)
  # [1] 0.015625
  
  # Story 2: Start with 7 balls Randomly throw each ball onto the 
  # unit interval; then choose 6 balls at random and paint it gray. Again, let X be the 
  # number of white balls to the left of the gray ball.
  pbeta(1, 1, 6)
}


chap8.gamma.story <- function(a_max=10, poisson_rate=10) {
  # in the poisson story, a is the number of successes we are waiting for,
  # and lambda is the rate at which successes arrive; Y ~ Gamma(a, lambda) is 
  # the total waiting time for the ath arrival in a Poisson process of rate lambda.
  
  # so... if I threw a gray ball on the unit interval [0, 1], what is the probability
  # that all (a) white balls will arrive if they arrive at the rate lambda.
  x <- seq(0, 1, 0.01)
  
  df <- data.frame(x=x)
  
  for(i in 0:a_max){
    df[sprintf("%s", i)] <- pgamma(x, i, poisson_rate)
  }

  meltdf <- melt(df, id="x")

  ggplot(meltdf, aes(x=x, y=value, color=variable, group=variable)) +
    geom_line() + 
    labs(title=sprintf("Gamma(a, %s): Notice PDF shifts right as (a) increases.", poisson_rate)) +
    labs(x="x: Total waiting time on iterval [0,1]") +
    labs(y="y: P(num_success=a | poisson_rate)")
}

chap8.beta.story <- function(a=6, b=1) {
  x <- seq(0, 1, 0.01)
  
  # pg 353
  # Story 1: Start with (n coin tosses + 1): 7 balls, 6 white, 1 gray. Throw the gray ball at the
  # 0.5 location on the unit interval [0,1]. Let X be the number of white balls to the left of the
  # grey ball.
  
  # Story 2: Start with 7 balls, 6 white, 1 gray. Randomly throw each ball onto the 
  # unit interval; then choose one ball at random and paint it gray. Again, let X be the 
  # number of white balls to the left of the gray ball.
  
  
  # pbeta(0.5, 6, 1)
  # [1] 0.015625
  
  df <- data.frame(x=x)
  
  for(i in 0:a){
    df[sprintf("%s", i)] <- pbeta(x, i, b)
  }
  
  meltdf <- melt(df, id="x")
  
  ggplot(meltdf, aes(x=x, y=value, color=variable, group=variable)) +
    geom_line() + 
    labs(title=sprintf("beta(a, %s): Notice PDF shifts right as (a) increases.", b)) +
    labs(x="x: Location of 'failure' event [0,1]") +
    labs(y="y: P(num_success=a)")
  
  # 
  # chap8.beta.story(b=6)

}



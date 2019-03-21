source("utils.R")
# output_png="mean_eeg_channels.png"


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
  
  p <- ggplot(meltdf, aes(x=x, y=value, color=variable, group=variable)) +
    geom_line() + 
    ggtitle(sprintf("Gamma(a, %s)", poisson_rate)) +
    theme(plot.title = element_text(hjust = 0.5)) +
    labs(x="x: Total waiting time on iterval [0,1]") +
    labs(y="y: P(num_success=a | poisson_rate)")
  
  save_plot_filename = sprintf("pgamma_a_max_%s_poisson_rate_%s.png", a_max, poisson_rate)
  save_plot(p, save_plot_filename)
  
  p
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
  
  p <- ggplot(meltdf, aes(x=x, y=value, color=variable, group=variable)) +
    geom_line() + 
    labs(x="x: Location of 'failure' event [0,1]") +
    labs(y="y: P(num_success=a)") + 
    ggtitle(sprintf("beta(a, %s)", b)) +
    theme(plot.title = element_text(hjust = 0.5))
  
  # random location of 6 failures, 
  # gets higher P(success) at smaller x
  # > P(success) because so many failure events to choose from? :-)
  # chap8.beta.story(b=6)
  
  save_plot_filename = sprintf("pbeta_a_%s_b_%s.png", a, b)
  save_plot(p, save_plot_filename)
  
  p
  
}
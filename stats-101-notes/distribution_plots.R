source("utils.R")
# output_png="mean_eeg_channels.png"

chap3.poisson.story <- function(num_success=3, rate=2.5, interval=4) {
  # The Poisson distribution is often used in situations where we are counting the number of successes
  # in a particular region or interval of time and there are a large
  # number of trials, each witha small probability of success. 
  
  # the parameter lambda is interpreted as the rate of occurrence of these rare events;
  # lambda could be 20 (emails per hour), 10 (chips per cookie), and 2 
  # (earthquakes per year). The poisson paradigm says that in applications simoilar to
  # the ones above, we can approximate the distribution of the number of events that
  # occur by a Poisson Distribution()
  
  # The number of people that show up at a bus stop is Poisson with a mean of 2.5 per hour. 
  # If watching the bus stop for 4 hours, what is the 
  # probability that $3$ or fewer people show up for the whole time?
  
  # Notice the multiplication by four in the function argument. Since lambda is specified as 
  # events per hour we have to multiply by four to consider the number of events that occur in 4 hours.
  lambda <- rate * interval
  x <- seq(0, num_success+1, 0.01)
  df <- data.frame(x=x)
  
  df['y'] <- ppois(x, lambda)
  p <- ggplot(df, aes(x=x, y=y)) +
    geom_line() +
    labs(y="y: P(num_success=x | lambda)") + 
    labs(x="x: number of events")
  
  p
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
  
  p <- ggplot(meltdf, aes(x=x, y=value, color=variable, group=variable)) +
    geom_line() + 
    ggtitle(sprintf("Gamma(a, %s)", poisson_rate)) +
    theme(plot.title = element_text(hjust = 0.5)) +
    labs(x="x: Total waiting time on iterval [0,1]") +
    labs(y="y: P(num_success=a | poisson_rate)")
  
  save_plot_filename = sprintf("plots/pgamma_a_max_%s_poisson_rate_%s.png", a_max, poisson_rate)
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
  
  save_plot_filename = sprintf("plots/pbeta_a_%s_b_%s.png", a, b)
  save_plot(p, save_plot_filename)
  
  p
}



# ## Uniform Distribution
# 
# Consider
# 
# ```{r dunif, echo=F, fig.width=6, fig.height=4, fig.align = "center"}
# do_unif <- function() {
#   # PDF
#   x <- seq(-0.5, 1.5, 1/10000)
#   y <- dunif(x, 0, 1)
#   # plot(x, y, type="l", xlab="x", ylab = "dunif(x)", main="Uniform Density PDF")
#   # curve(dunif, from=-3, to=3, n=10000)
#   datums <- data.frame(x=x, y=y)
#   g <- ggplot(datums, aes(x, y)) + geom_line() + 
#     theme(plot.title = element_text(hjust = 0.5)) +
#     labs(title="Uniform PDF")
#   g
# }
# 
# do_unif()
# ```
# 
# ```{r punif, echo=F, fig.width=6, fig.height=4, fig.align = "center"}
# do_punif <- function() {
#   # CDF
#   x <- seq(0, 1, 1/1000)
#   y <- punif(x, 0, 1)
#   # plot(x, y, type="l", main="Uniform Density CDF")
#   datums <- data.frame(x=x, y=y)
#   g <- ggplot(datums, aes(x, y)) + geom_line() + 
#     theme(plot.title = element_text(hjust = 0.5)) +
#     labs(title="Uniform CDF")
#   g
# }
# 
# do_punif()
# ```
# 
# ## Normal Distribution
# 
# ```{r dnorm, echo=F, fig.width=6, fig.height=4, fig.align = "center}
# do_dnorm <- function() {
# x <- seq(-3, 3, 0.01)
# y <- dnorm(x)
# datums <- data.frame(x=x, y=y)
# g <- ggplot(datums, aes(x, y)) + geom_line() + 
# theme(plot.title = element_text(hjust = 0.5)) +
# labs(title="Normal Dist PDF")
# g
# }
# 
# do_dnorm()
# ```
# 
# 
# ```{r pnorm, echo=F, fig.width=6, fig.height=4, fig.align = "center}
# do_pnorm <- function() {
#   x <- seq(0, 1, 0.001)
#   y <- pnorm(x)
#   df <- data.frame(x=x, y=y)
#   ggplot(df, aes(x=x, y=y)) + geom_line() + 
#     theme(plot.title = element_text(hjust = 0.5)) +
#     labs(title="Normal Dist CDF")
# }
# 
# do_pnorm()
# ```






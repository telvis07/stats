library(ggplot2)
library(gridExtra)

chap13.1 <- function() {
  # 1D poisson process. 
  # Story 13.2.3 tells us how to simulare a Poisson process within a specified interval (0,L]
  
  # Generate the number of arrivals N(L) which is distributed Pois(lambda*L).
  # Conditional on N(L) = n, the arrival times are distributed as the order statistics
  # of n i.i.d Unif(O,L) r.v.s
  # The following code simulates arrivals from a Poisson process with rate 10 in the interval (0,5]
  L <- 5
  lambda <- 10
  
  # randomly generatent number of events using pois(lambda*L)
  n <- rpois(1, lambda*L)
  
  # generate random "times" from 0 through L for "n" events, then sort them
  t <- sort(runif(n, 0, L))
  
  # visualize L events. 
  # x=times each n event occurs
  # y=event index
  df <- data.frame(x=t, y=1:n)
  g <- ggplot(df, aes(x=x, y=y) ) +
    geom_step() +     
    scale_y_continuous(name= "N(t): Number of successes at t") +
    scale_x_continuous(name= "Time t")
  
  g
}


chap13.2 <- function() {
  # 5 intervals
  L <- 5
  
  # 10 events/interval
  lambda <- 10
  
  # randomly generate number of events using pois(lambda*L)
  n <- rpois(1, lambda*L)
  
  # generate random "times" from 0 through L for "n" events, then sort them
  t <- sort(runif(n, 0, L))
  
  # type-1 event probabilty: p=0.3
  p <- 0.3
  y <- rbinom(n, 1, p)
  
  # assign "event times" as type-1 or type-2 
  t1 <- t[y==1]
  t2 <- t[y==0]
  
  # as before, we can plot the number of arrivals in each Poisson process: N_1(t) and N_2(t).
  
  # visualize the plot for type #1 events
  df <- data.frame(x=t1, y=1:length(t1))
  p1 <- ggplot(df, aes(x=x, y=y) ) +
    geom_step() +     
    scale_y_continuous(name= "N_1(t): Number of successes at t") +
    scale_x_continuous(name= "Time t")
  
  # visualize the plot for type #2 events
  df <- data.frame(x=t2, y=1:length(t2))
  p2 <- ggplot(df, aes(x=x, y=y) ) +
    geom_step() +     
    scale_y_continuous(name= "N_2(t): Number of successes at t") +
    scale_x_continuous(name= "Time t")
  
  
  grid.arrange(p1, p2, nrow=1)
}


pois.timeline <- function() {
  # Thinning
  
  # 1D poisson process. 
  # Story 13.2.3 tells us how to simulate a Poisson process within a specified interval (0,L]
  
  # Generate the number of arrivals N(L) which is distributed Pois(lambda*L).
  # Conditional on N(L) = n, the arrival times are distributed as the order statistics
  # of n i.i.d Unif(O,L) r.v.s
  # The following code simulates arrivals from a Poisson process with rate 10 in the interval (0,5]
  L <- 5
  lambda <- 10
  
  # randomly generatent number of events using pois(lambda*L)
  n <- rpois(1, lambda*L)
  
  # generate random "times" from 0 through L for "n" events, then sort them
  t <- sort(runif(n, 0, L))
  
  # the following code starts with a vector of arrival times t and the corresponding
  # number of arrivals n, generated according to the pois process. For each arrival,
  # we flip a coin with probability p of Heads; these coin tosses are labeled as type-1;
  # the rest are labeld as type-2. The resulting vectors of arrival times t1 and t2 are 
  # realizations of independent Poisson processes, by Theorem 13.2.13. 
  
  # To perform this in R with p=0.3, we can type
  p <- 0.3
  y <- rbinom(n, 1, p)
  
  # assign "event times" as type-1 or type-2 
  t1 <- t[y==1]
  t2 <- t[y==0]
  
  # as before, we can plot the number of arrivals in each Poisson process: N_1(t) and N_2(t).
  
  # visualize the plot for type #1 events
  df <- data.frame(x=t1, y=1:length(t1))
  p1 <- ggplot(df, aes(x=x, y=y) ) +
    geom_point()  +
    theme(
          axis.ticks.y=element_blank()) +
  ylab("type1: event count") +
  xlab("Time t")
  # scale_y_continuous(name= "N_1(t): Number of successes at t") +
  # scale_x_continuous(name= "Time t")
  
  # visualize the plot for type #2 events
  df <- data.frame(x=t2, y=1:length(t2))
  p2 <- ggplot(df, aes(x=x, y=y) ) +
    geom_point()  +
    theme(
          axis.ticks.y=element_blank()) +
    ylab("type2: event count") +
    xlab("Time t")
  # scale_y_continuous(name= "N_2(t): Number of successes at t") +
  # scale_x_continuous(name= "Time t")
  
  grid.arrange(p1, p2, nrow=2)
}






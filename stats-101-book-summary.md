---
title: "Stats 101: Common Probability Distributions"
author: "technicalelvis.com"
output: 
  html_document:
    toc: true
    theme: cosmo
    keep_md: true
    pandoc_args: [
      "-o", "index.html",
      "-o", "README.md"
    ]


fig_width: 5 
fig_height: 3 
---



NOTE: [Click here to view the github page for this repo](https://telvis07.github.io/stats/)

## Common Probability Distributions

This document lists common probability distributions described in [Introduction to Probability by Joseph Blizstein and Jessica Hwang](https://drive.google.com/file/d/1VmkAAGOYCTORq1wxSQqy255qLJjTNvBI/view). For each distribution, we show both the _probability density_ and _cumulative distribution_ plots. 

**Probability density** plots show the _exact probability_ that a random variable $X$ equals a some value $x$; expressed using the notation: $P(X=x)$. 

**Cumulative distribution** plots show the probablity that a random variable $X$ _is less than or equal to_ some value $x$; expressed using the notation $P(X<=x)$.

The cumulative distribution answers questions like: 

* "probability a person's height equals 4 feet __or shorter__"
* "probability a cookie has __at least__ 10 chocolate chips"
* "probability a shopping cart has 3 items __or fewer__". 

The __emphasized__ phrases indicate we want the total population up to a certain value. 
This contrasts with probability density, that answers questions like:

* "probability a person's height __exactly equals__ 4 feet"
* "probability a cookie has __exactly__ 10 chocolate chips"
* "probability a shopping cart has __exactly__ 3 items".

The __emphasized__ phrases indicate we want the slice of the population that exactly equals a certain value.


## Binomial
Suppose that _n_ independent Bernoulli trials are performed, each with the same success probability p. Let
_X_ be the number of successes. The distribution of X is called a _Binomial distribution_. For example, let 

### Binomial Density
A density plot shows the probability that a random variable *equals* some discrete value. The plot shows the probability of getting *exactly* _x_ HEADS in 10 coin flips where the probability of HEADS is 20%.

<img src="stats-101-book-summary_files/figure-html/dbinom-1.png" style="display: block; margin: auto;" />


### Binomial Cumulative distribution

The distribution plot shows the probability that a random variable *is less than* some value. The plot shows the probability of getting *less than* _x_ HEADS in 10 coin flips where the probability of HEADS is 20%.

<img src="stats-101-book-summary_files/figure-html/pbinom-1.png" style="display: block; margin: auto;" />


## Hypergeometric

Consider a playing cards example with _a_ aces and _b_ non-aces (ie. the 48 other cards that are not aces). We draw _n_ cards out of the deck at random without replacement, such that 
${a + b \choose n}$ cards are equally likely. Let _X_ be the number of aces in the in your hand after drawing _n_ cards. _X_ is said to have the
_Hypergeometric distribution_ with parameters a, b and n; we denote this by _X ~ HGeom(a,b,n)_.

### Hypergeometric Density

The plot shows the probability of having *exactly* 1, 2, 3, or 4 aces in a 5 card hand from a deck with 52 cards.

<img src="stats-101-book-summary_files/figure-html/dhyper-1.png" style="display: block; margin: auto;" />

### Hypergeometric Cumulative Distribution

The plot shows the probability of having *less than* 1, 2, 3, or 4 aces in a 5 card hand from a deck containing 52 cards.

<img src="stats-101-book-summary_files/figure-html/phyper-1.png" style="display: block; margin: auto;" />


## Uniform

A uniform r.v. on the interval (a,b) is a completely random number between _a_ and _b_. The PDF is _constant_ over the interval.

### Uniform Density

The following plot shows the probability that `Unif(0,1)` is *less than or equal* to any value between -0.5 and +1.5.

<img src="stats-101-book-summary_files/figure-html/dunif-1.png" style="display: block; margin: auto;" />

### Uniform Cumulative Distribution

The following plot shows the probability that `Unif(0,1)` is *exactly equals* any value between -0.5 and +1.5.

<img src="stats-101-book-summary_files/figure-html/punif-1.png" style="display: block; margin: auto;" />



## Poisson

The Poisson distribution is often used in situations where we are counting the number of successes in a particular region or interval of time and there are a large number of trials. Each trial has a small probability of success. The parameter lambda ($\lambda$) is interpreted as the rate of occurrence of these rare events.

$\lambda$ could be 20 (emails per hour), 10 (chips per cookie), and 2 (earthquakes per year). The poisson paradigm says that in applications similar to the ones above, we can approximate the distribution of the number of events that occur by a Poisson Distribution.

### Poisson Density
Consider an example where the number of people that show up at a bus stop is Poisson with a mean of 2.5 per hour. If watching the bus stop for 1 hours, what is the 
probability that exactly $3$ people show up for the whole time?

<img src="stats-101-book-summary_files/figure-html/dpois-1.png" style="display: block; margin: auto;" />


### Poisson Cumulative Distribution
For the previous example, what is the probability that $3$ or fewer people show up for the whole time?

<img src="stats-101-book-summary_files/figure-html/ppois-1.png" style="display: block; margin: auto;" />

### Simulating a Poisson Process containing 1 event type
The following example illustrates how to simulate arrival times within a specified interval $(0,L]$. 

1. Generate the number of arrivals $N(L)$ from $Pois(\lambda*L)$. 
2. Conditional on $N(L) = n$, generate arrival times from ordered `Unif(O,L)`. 

The following code simulates arrivals from a Poisson process with rate 10 events/interval after observing for 5 intervals.


```r
pois.1 <- function() {

  # 5 intervals
  L <- 5
  
  # 10 events / interval
  lambda <- 10
  
  # randomly generate number of events using pois(lambda*L)
  n <- rpois(1, lambda*L)
  
  # generate random "times" from 0 through L for "n" events, then sort them
  t <- sort(runif(n, 0, L))
  
  # visualize L events. 
  # x=times each n event occurs
  # y=event index
  df <- data.frame(x=t, y=1:n)
  g <- ggplot(df, aes(x=x, y=y) ) +
    geom_point() +     
    scale_y_continuous(name= "N(t): Number of successes at t") +
    scale_x_continuous(name= "Time t (intevals)")
  
  g
}

pois.1()
```

<img src="stats-101-book-summary_files/figure-html/poisson1-1.png" style="display: block; margin: auto;" />

### Simulating a Poisson Process containing 2 event types

Now, let's build on the previous example to model a Poisson process that contains 2 event types.

1. Generate the number of arrivals $N(L)$ from $Pois(\lambda*L)$. 
2. Conditional on $N(L) = n$, generate arrival times from ordered `Unif(O,L)`. 
3. For each arrival, we flip a coin with probability `Bern(0.3)` of Heads; these coin tosses are labeled as `type-1`; the rest are labeled as `type-2`. 
  
The resulting vectors of arrival times t1 and t2 are realizations of 2 independent Poisson processes.


```r
pois.2 <- function() {
  
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
  df1 <- data.frame(x=t1, y=1:length(t1))
  p1 <- ggplot(df1, aes(x=x, y=y) ) +
    geom_point(shape=16, color="blue")  +
    theme(
          axis.ticks.y=element_blank()) +
  ylab("type1: count") +
    theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())
  
  # visualize the plot for type #2 events
  df2 <- data.frame(x=t2, y=1:length(t2))
  p2 <- ggplot(df2, aes(x=x, y=y) ) +
    geom_point(shape=17, color="orange")  +
    theme(
          axis.ticks.y=element_blank()) +
    ylab("type2: count") +
      theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())
  
  # visualize the plot for both event types
  df1$event_type <- "type-1"
  df2$event_type <- "type-2"
  df3 <- rbind(df1, df2)
  df3$y <- 1:length(t)
  
  p3 <- ggplot(df3, aes(x=x, y=y, color=event_type) ) +
    geom_point()  +
    theme(
          axis.ticks.y=element_blank()) +
    ylab("combined") +
    xlab("Time t (intervals)") +
    scale_shape_manual(values=c(16, 17))+
    scale_color_manual(values=c('blue','orange')) +
    theme(legend.position="none")
  
  grid.arrange(p1, p2, p3, nrow=3)
}

pois.2()
```

<img src="stats-101-book-summary_files/figure-html/poisson2-1.png" style="display: block; margin: auto;" />

## Gaussian

The Normal distribution is a famous continuous distribution with a bell-shaped PDF. It is extremely widely used in statistics because of a theorem,
the [central limit theorem](https://github.com/telvis07/StatsInf_PeerAssessment1/blob/master/project.md), which says under very weak assumptions, the sum of a large number of i.i.d. random variables has an approximately Normal 
distribution - regardless of the distribution of the underlying random variable.

The simplest normal distribution is the _standard normal_, which is centered at 0 and has a variance of 1.

### Gaussian Density

The following plot shows the probability that `Normal(0,1)` is *less than or equal* to any value between -3 and +3.
 
<img src="stats-101-book-summary_files/figure-html/dnorm-1.png" style="display: block; margin: auto;" />


### Gaussian Cumulative Distribution

The following plot shows the probability that `Normal(0,1)` *exactly equals* any value between -3 and +3.
 

<img src="stats-101-book-summary_files/figure-html/pnorm-1.png" style="display: block; margin: auto;" />


### Multivariate Normal

A multivariate (MVN) normal distribution generalizes the Normal distribution into higher dimension. The parameters of a multi-variate normal are:

1. The _mean vector_ ($\mu_1, \mu_2, ... \mu_n$)
2. The _covariance matrix_, which is the _k x k_ matrix of covariances between components, arranged so that the
row _i_, column _j_ entry is Cov($X_i, X_j$).

The following plot shows random variables from 2 bivariate normals: `BLUE` and `ORANGE`. The `BLUE` distribution has parameters
$N((1,0)^T, I)$. The `ORANGE` distribition has parameters $N((0,1)T, I)$. **I** represents a 2x2 identity matrix - where the diagonals are `1` and other values are `0`.


```r
do_mvtnorm <- function(mu1, mu2, s1=1, s2=1, rho_0=0, N=10) {
  # dvmnorm can be used for calculating the joing PDF and rmvnorm can be used for 
  # generating random vectors.
  meanvector <- c(mu1,mu2)

  # The covariance matrix is (assuming sd(Z)=s1=1, sd(W)=s2=1)
  # [(1, rho), (rho, 1)]
  # because:
  # Cov(Z, Z) = Var(Z) = 1 (this is the upper left entry)
  # Cov(W, W) = Var(W) = 1 (this is the lower right entry)
  # Cov(Z, W) = Corr(Z,W) * sd(Z) * sd(W) = rho 
  # 
  # NOTE (if rho_0=1, then covmatrix equals IDENTITY matrix(c(1, 0, 0, 1), 2))
  covmatrix = matrix(c(s1^2, s1*s2*rho_0, s1*s2*rho_0, s2^2), nrow=2, ncol=2)

  # now r  is N x 2 matrix, with each row a BVN random vector. 
  r <- rmvnorm(n=N, mean=meanvector, sigma=covmatrix)

  r
}

generate_mvn_plot <- function(N=100) {
  # N((1,0)^T, I) labeled class 'BLUE'
  bvn1 <- do_mvtnorm(mu1=1, mu2=0, s1=1, s2=1, rho_0=0, N=N)
  df1 <- data.frame(bvn1)
  colnames(df1) <- c("x1", "x2")
  df1["label"] = "BLUE"

  # N((0,1)T, I) labeled class 'ORANGE'
  bvn2 <- do_mvtnorm(mu1=0, mu2=1, s1=1, s2=1, rho_0=0,  N=N)
  df2 <- data.frame(bvn2)
  colnames(df2) <- c("x1", "x2")
  df2["label"] = "ORANGE"

  # stack the dataframes
  df <- rbind(df1, df2)

  # Plot BLUE vs ORANGE
  g <- ggplot(df, aes(x=x1, y=x2, color=label)) +
    geom_point() +
    scale_color_manual(breaks = c("BLUE", "ORANGE"),
                       values=c("blue", "orange"))
  g
}

generate_mvn_plot()
```

<img src="stats-101-book-summary_files/figure-html/mvnplot-1.png" style="display: block; margin: auto;" />



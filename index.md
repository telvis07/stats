---
title: "Stats 101"
author: "technicalelvis.com"
output: 
  html_document:
    toc: true
    theme: cosmo
    keep_md: true

fig_width: 5 
fig_height: 3 
---




## Common Probability Distributions

This document lists common probability distributions described in

* [Introduction to Probability by Joseph Blizstein and Jessica Hwang](https://drive.google.com/file/d/1VmkAAGOYCTORq1wxSQqy255qLJjTNvBI/view). 

* [Little Inference Book by Brian Caffo](https://leanpub.com/LittleInferenceBook)


For each distribution, we show both the _probability density_ and _cumulative distribution_ plots. 

**Probability density** plots show the probability that a random variable $X$ equals some value $x$; expressed using the notation: $P(X=x)$. 

**Cumulative distribution** plots show the probablity that a random variable $X$ _is less than or equal to_ some value $x$; expressed using the notation $P(X<=x)$.

The cumulative distribution answers questions like: 

* "probability a person's height is __greater than__ 4 feet"
* "probability a cookie has __less than__ 10 chocolate chips"
* "probability a shopping cart has __greater than__ 3 items". 

The __emphasized__ phrases indicate we want the total population with a value in a certain range. 
This contrasts with probability density, that answers questions like:

* "probability a person's height __exactly equals__ 4 feet"
* "probability a cookie has __exactly__ 10 chocolate chips"
* "probability a shopping cart has __exactly__ 3 items".

The __emphasized__ phrases indicate we want the slice of the population that exactly equals a certain value. 

### Setting lower.tail parameter in R

The `R` distribution functions (eg. pbinom, ppois, pnorm, etc.) have a `lower.tail` option to get the range above or below a threshold. 

* Set `lower.tail = FALSE` to get the population percentage __above__ a threshold.
* Set `lower.tail = TRUE` to get the population percentage __below__ a threshold.


### Distribution vs Density

In general, the term `distribution` is used to describe statistics on discrete variables (eg. item counts, customer counts, etc). The `density` applies to 
continuous variables that can take any value from $-inf$ to $+inf$ (eg. heights, weights, etc. )


## Binomial
Suppose that _n_ independent coin flips (ie. Bernoulli trials) are performed, each with the same success probability p. Let
_X_ be the number of HEADS (ie. successes). The distribution of X is called a _Binomial distribution_. 

### Binomial Density
The plot shows the probability of getting *exactly* _x_ HEADS in 10 biased coin flips where the probability of HEADS is 20%.

<img src="index_files/figure-html/dbinom-1.png" style="display: block; margin: auto;" />


### Binomial Cumulative distribution

The plot shows the probability of getting greater than _x_ HEADS in 10 coin flips where the probability of HEADS is 20%.

<img src="index_files/figure-html/pbinom-1.png" style="display: block; margin: auto;" />



## Poisson

The Poisson distribution is often used in situations where we are counting the number of successes in a particular region or interval of time and there are a large number of trials. Each trial has a small probability of success. The parameter lambda ($\lambda$) is interpreted as the rate of occurrence of these rare events.

$\lambda$ could be 20 (emails per hour), 10 (chips per cookie), and 2 (earthquakes per year). The poisson paradigm says that in applications similar to the ones above, we can approximate the distribution of the number of events that occur by a Poisson Distribution.

### Poisson Density
Consider an example where the number of people that show up at a bus stop is Poisson with a mean of 2.5 per hour. If watching the bus stop for 1 hours, what is the 
probability that exactly $x$ people show up for the whole time?

<img src="index_files/figure-html/dpois-1.png" style="display: block; margin: auto;" />


### Poisson Cumulative Distribution
For the previous example, what is the probability that more than $x$ people show up for the whole time?

<img src="index_files/figure-html/ppois-1.png" style="display: block; margin: auto;" />

### Simulating a Poisson Process containing 1 event type
The following example illustrates how to simulate arrival times within a specified interval $(0,L]$. 

1. Generate the number of arrivals $N(L)$ from $Pois(\lambda*L)$. 
2. Conditional on $N(L) = n$, generate arrival times from ordered `Unif(O,L)`. 

The following plot simulates arrivals from a Poisson process with rate 10 events/interval after observing for 5 intervals.

<img src="index_files/figure-html/poisson1-1.png" style="display: block; margin: auto;" />

### Simulating a Poisson Process containing 2 event types

Now, let's build on the previous example to model a Poisson process that contains 2 event types.

1. Generate the number of arrivals $N(L)$ from $Pois(\lambda*L)$. 
2. Conditional on $N(L) = n$, generate arrival times from ordered `Unif(O,L)`. 
3. For each arrival, we flip a coin with probability `Bern(0.3)` of Heads; these coin tosses are labeled as `type-1`; the rest are labeled as `type-2`. 
  
The resulting vectors of arrival times t1 and t2 are realizations of 2 independent Poisson processes.

<img src="index_files/figure-html/poisson2-1.png" style="display: block; margin: auto;" />

## Gaussian

The Normal distribution is a famous continuous distribution with a bell-shaped PDF. It is extremely widely used in statistics because of a theorem,
the [central limit theorem](https://github.com/telvis07/StatsInf_PeerAssessment1/blob/master/project.md), which says under very weak assumptions, the sum of a large number of i.i.d. random variables has an approximately Normal 
distribution - regardless of the distribution of the underlying random variable.

The simplest normal distribution is the _standard normal_, which is centered at 0 and has a variance of 1.

### Gaussian Density

The following plot shows the probability that `Normal(0,1)` *exactly equals* any value between -3 and +3.

 
<img src="index_files/figure-html/dnorm-1.png" style="display: block; margin: auto;" />


### Gaussian Cumulative Distribution

The following plot shows the probability that `Normal(0,1)` is *greater than* to any value between -3 and +3.

 
<img src="index_files/figure-html/pnorm-1.png" style="display: block; margin: auto;" />

### Click Fraud Rate Simulation

Lets' consider a [click fraud detection event analysis](https://www.kaggle.com/c/talkingdata-adtracking-fraud-detection) where 1 out of 100 ad clicks is fraudulent (ie. fraud rate is 1%).

If we had a very large dataset, we could run `2000` experiments where we calculate the fraud rate of small samples. According to the [central limit theorem](https://github.com/telvis07/StatsInf_PeerAssessment1/blob/master/project.md), we can take the average fraud rate across all the experiments and be close to the actual fraud rate.


<img src="index_files/figure-html/fraudrate-1.png" style="display: block; margin: auto;" />

The plot above shows a histogram of the fraud rates for each sample. We try sizes of 10, 100, 200 and 500 samples. Notice that as the sample size grows, the distribution gets Gaussian looking (like a bell curve) and increasinsly centered at 0.01 (1%).

### Multivariate Normal

A multivariate (MVN) normal distribution generalizes the Normal distribution into higher dimension. The parameters of a multi-variate normal are:

1. The _mean vector_ ($\mu_1, \mu_2, ... \mu_n$)
2. The _covariance matrix_, which is the _k x k_ matrix of covariances between components, arranged so that the
row _i_, column _j_ entry is Cov($X_i, X_j$).

The following plot shows random variables from 2 bivariate normals: `BLUE` and `ORANGE`. The `BLUE` distribution has parameters
$N((1,0)^T, I)$. The `ORANGE` distribution has parameters $N((0,1)^T, I)$. **I** represents a 2x2 identity matrix - where the diagonals are `1` and other values are `0`.

<img src="index_files/figure-html/mvnplot-1.png" style="display: block; margin: auto;" />



# Moment Generating Function
# Let's use the norm(0,1) MGF which is given by M(t) = exp(t^2)/2
M <- function(t){ exp(t^2/ 2)}

mgf.example.1 <- function() {
  # M(0) evaluates the function at 0. M(1:10) evaluates the function at 1,2 ... 10
  # this plots M from [-3, 3]
  curve(M, from=-3, to=3)
  title("example 1")
}

# MGF for norm(mu, sigma^2)
g.1 <- function(t, mean=0, sd=1) {exp(mean*t + sd^2*t^2/2)}

# approximate the 6th moment of norm(0,1)
g.2 <- function(x) {x^6*dnorm(x)}
# integrate(g.2, lower = -Inf, upper=Inf)

# sample skew: 
skew.1 <- function(x) {
  centralmoment <- mean((x-mean(x))^3)
  centralmoment/(sd(x)^3)
}

# sample kurtosis
kurt.1 <- function(x) {
  centralmoment <- mean((x-mean(x))^4)
  centralmoment/(sd(x)^4) - 1
}


# For finding the mode of a continuous distribution, we can use the optimize function
# in R. Let's find the mode of the Gamma(6,1) distribution. Its PDF is 
# proportional to X^5*e(-x). Using calculus, we can find that the mode is at x=5.

# optimize(h.1, lower=0, upper=20, maximum = T)
# If we had wanted to minimize instead of maximize, we could have put maximum=FALSE
h.1 <- function(x){
  x^5*exp(-x)
}

# For Bin(n, p) distribution, if np is an integer, then median and mode are np

# The which.max function finds the location of the maximum of a vector, giving the index of the first occurrence of the 
# maximum. The maximum if the first value where the value is at least 0.5.
# For n=50, p=0.2; the answer is 10. The results shows index 11, which is "off by one" to the right answer : 10. 
discrete.median <- function(){
  n <- 50; p <- 0.2
  which.max(pbinom(0:n, n, p)>=0.5)
}

# The sample mode cannot be found using mode(x). It return information about what type of object x is.
# Use "table" to create a frequency table, then max to find the most frequent entry. 
# then show the "key" for the most frequent index using.

# data.mode(pbinom(1:50, 50, 0.2))
data.mode <- function(x){
  t <- table(x)
  m <- max(t)
  as.numeric(names(t[t==m]))
}

# simulate the probability of rolling 6 dice (each dice has values [1,6]) and getting a value
# of 18.

dice.simulation <- function(){
  r <- replicate(10^6, sum(sample(6,6,replace=T)))
  sum(r==18)/10^6
}











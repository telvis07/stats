library(ggplot2)

binom_prob <- function(k){1-prod((365-k+1):365)/(365^k)}

chap1.1 <- function() {
  k <- 1:100
  p <- sapply(k, binom_prob)
  
  df <- data.frame(k=k, p=p)
  g <- ggplot(df, aes(x=k, y=p)) +
    geom_point() +
    xlab("k") + ylab("probability of a birthday match") +
    geom_hline(yintercept=0.50, linetype="dashed", color = "red") +
    theme(plot.title = element_text(hjust = 0.5)) +
    labs(title="Probability that in a room of k people, \nat least two were born on the same day.")
  g
}
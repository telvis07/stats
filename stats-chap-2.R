# Blitzstein : Chaper 2: Conditional Probability

simulating_frequentist <- function() {
  # Let A be the event that both children are girls
  # Let B be the event that the eldest is a girl
  # P(A | B) 
  #    = P(A, B) / P(B)         // (A intersect B); (A & B)
  #    = P(B | A) * P(A) / P(B)
 
  # 
  n <- 10 ^ 5
  child1 <- sample(2, n, replace=TRUE)
  child2 <- sample(2, n, replace = TRUE)
  child1[0:10]
  n.b <- sum(child1==1)
  n.ab <- sum(child1==1 & child2 == 1)
  print("Prob both are girls given eldist is a girl")
  print(n.ab/n.b)
  
  # at least one child is a girl
  n.b <- sum(child1==1 | child2==1)
  n.ab <- sum(child1 == 1 & child2==1)
  
  print("Prob both are girls that at least 1 is a girl")
  print(n.ab / n.b)
}

monty <- function() {
  doors <- 1:3
  
  # randomly pick where the car is
  cardoor <- sample(doors, 1)
  
  # prompt player
  print("Monty Hall says 'Pick a door, any door'")
  
  # receive the player's choice of door (should be 1, 2, 3)
  chosen <- scan(what=integer(), nlines =1, quiet = T)
  
  # pick Monty's door (can't be the player's door or the car door)
  if (chosen != cardoor) montydoor <- doors[-c(chosen, cardoor)]
  else montydoor <- sample(doors[-chosen], 1)
  
  # find out whether the player wants to switch doors
  print(paste("Monty opens door ", montydoor, "!", sep = ""))
  print("Would you like to switch (y/n)")
  reply <- scan(what = character(), nlines=1, quiet=T)
  
  # intepret what player wrote as yes if it startes with y
  if (substr(reply, 1, 1) == "y") chosen <- doors[-c(chosen, montydoor)]
  
  # announce the result of the game
  if (chosen == cardoor) print ("You won!")
  else print("sad trombone.....")
}
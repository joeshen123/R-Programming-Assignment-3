rankhospital <- function(state, outcome, num = "best"){
  # Read outcome data
  data <- read.csv("outcome-of-care-measures.csv")
  
  # Establish a vector of possible outcome names
  vect <- c("heart attack", "heart failure", "pneumonia")
  
  # Check that state and outcome are valid
  if (!is.element(state, data$State)) {
    stop("invalid state")
  }
  
  if (!is.element(outcome, vect)) {
    stop("invalid outcome")
  }
  
  # Provide different column number according to different outcomes
  if (outcome == "heart attack") {
    colnum <- 11
  }
  
  if (outcome == "heart failure") {
    colnum <- 17
  }
  
  if (outcome == "pneumonia") {
    colnum <- 23
  }
  
  # Convert hospital names from factors to vector of character
  data[,2] <- as.character(data[,2])
  
  # Convert 30 days mortality rates from factors to numeric vectors, use supressWarnings
  # to get rid of warnings
  data[,colnum] <- suppressWarnings(as.numeric(levels(data[,colnum])[data[,colnum]]))
  
  # Use grep function to subset the data from selected state
  state_data <- data[grep(state,data[,7]),]
  
  # Use order function to order the state based on their 30 days mortality and alphabetical names
  #remove the NA value
  state_data <- state_data[order(state_data[,colnum],state_data[,2],na.last = NA),]
  
  # Use if statement to assign number to best and worst, then extract the 
  #specifc hospital name in the ranking
  N <- sum(complete.cases(state_data[,colnum]))
  
  if (num == "best") {
    num <- 1
  }
  
  if (num == "worst") {
    num <- N
  }
  
  state_data[num, 2]
 
}
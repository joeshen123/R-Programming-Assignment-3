rankall <- function(outcome, num = "best"){
  # Read outcome data
  data <- read.csv("outcome-of-care-measures.csv")
  
  # Establish a vector of possible outcome names
  vect <- c("heart attack", "heart failure", "pneumonia")
  
  # Check the outcome is valid
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
  
  state_names <- c()
  hospital_names <- c()
  
  for (i in length(data[,7])) {
    
    state_names <- append(as.character(data[i, 7]), state_names)
    
    # Convert hospital names from factors to vector of character
    data[,2] <- as.character(data[,2])
    
    # Convert 30 days mortality rates from factors to numeric vectors, use supressWarnings
    # to get rid of warnings
    data[,colnum] <- suppressWarnings(as.numeric(levels(data[,colnum])[data[,colnum]]))
    
    # Use grep function to subset the data from selected state
    state_data <- data[grep(data[i, 7],data[,7]),]
    
    # Use order function order the state based on their 30 days mortality and alphabetical names
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
    
    hospital_names <- c(state_data[num, 2],hospital_names)
    }
  
  state_names
  
  }
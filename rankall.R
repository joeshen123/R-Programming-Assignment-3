rankall <- function(outcome, num = "best"){
  # Read outcome data
  data <- read.csv("outcome-of-care-measures.csv")
  
  # Establish a vector of possible outcome names
  vect <- c("heart attack", "heart failure", "pneumonia")
  
  #Check that outcome is valid
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
  
  # Make an empty vector called hospital_names, create another state_names vector that 
  #contains all the levels of State column
  hospital_names <- vector()
  state_names <- levels(data[,7])
  
  #Iterate using a for loop to append all hospital names with the same ranking in different
  #states to the hospital_names vector
  for (state in state_names) {
    
  # Use grep function to subset the data from selected state
  state_data <- data[grep(state, data[,7]),]
  
  # Use order function to order the state based on their 30 days mortality and alphabetical names
  #Remove the NA value
  state_data <- state_data[order(state_data[,colnum],state_data[,2],na.last = NA),]
  
  # Use if statement to assign number to best and worst (In other situation, set number <- num), 
  #then extract the specifc hospital name in the ranking
  N <- sum(complete.cases(state_data[,colnum]))
  
  if (num == "best") {
    number <- 1
  }
  
  else if (num == "worst") {
    number <- N
  }
  
  else {
    number <- num
  }
  
  # Append the hosptial name in to the vector
  hospital_names <- append(hospital_names, state_data[number, 2])
  }
  
  # Create a data frame with two columns: the hospital name and state names
  output_dataframe <- data.frame(hospital_names, state_names)
  
  # Set the column names
  colnames(output_dataframe) = c("hospital","state")
  
  # Set the row names
  rownames(output_dataframe) <- state_names
  
  # Return the dataframe on to the console
  output_dataframe

}
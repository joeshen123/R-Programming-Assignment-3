# R Programming Assignment 3
There are three parts (functions) in this assignment. 

The first function is in best.R. The purpose of this function is to find the best hospital (In a selected outcome)
in the state you select. The input of this function are the abbreviations of state name and the outcome you want to 
compare. If invalid input entered, it will stop the function and output error message. 

The second function is in rankhospital.R. It is a further development of the first function. It adds another input of ranking.
So it will return a character vector of the hospital name in a specific ranking. In addition, you can use "best" and "worst" as ranking 
ranking input to get the best hospital and worst hospital in the order.

The third function is in rankall.R. It is a further development of the second function. This function eliminates the input of
state abbreviation names. Instead, this function returns a dataframe that contains the hospital names of specific ranking in different 
states. The first column are the hospital names and the second column are the corresponding state name abbreviations.    

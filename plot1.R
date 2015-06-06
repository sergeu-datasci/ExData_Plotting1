## Course: Exploratory Data Analysis
## Assignment: Course Project 1
## Task: Draw 1st plot into plot1.png file
##
## USAGE:
##  1) In terminal, clone the GitHub repository to your computer:
##      git clone https://github.com/sergeu-datasci/ExData_Plotting1.git
##  2) Download and extract household_power_consumption.txt data file into 
##     ExData_Plotting1/data directory.
##  3) In R environment, set the repo directory as your working directory:
##      setwd("path/to/ExData_Plotting1")
##  4) Source plot1.R file:
##      source("plot1.R")
##  5) Run plot1 function:
##      plot1()

plot1 <- function() {
    data <- read_data()
    draw_to_png_1(data)
}

## Function definitions

## Function to read and prepare dataset for drawing
read_data <- function() {
    ## Read file
    file <- file.path("data", "household_power_consumption.txt")
    data <- read.csv(file, sep=";", na.strings = "?", stringsAsFactors = FALSE)
    
    ## Convert format from character to date and time
    time_full_str <- paste(data$Date, data$Time)
    data$Time <- strptime(time_full_str, "%d/%m/%Y %H:%M:%S")
    data$Date <- as.Date(data$Date, "%d/%m/%Y")
    
    ## Filter data for 2007-02-01 and 2007-02-02
    dates <- c(as.Date("2007-02-01"), as.Date("2007-02-02"))
    data <- data[data$Date %in% dates, ]
    
    ## Convert numeric data format
    data[, c(3:9)] <- sapply(data[, c(3:9)], as.numeric)
    
    ## Return prepared data frame
    return(data)
}

## Function to draw the plot into png file
draw_to_png_1 <- function(data) {
    png(filename = "plot1.png", width = 480, height = 480, units = "px")
    hist(data$Global_active_power,
         col = "Red",
         main = "Global Active Power",
         xlab = "Global Active Power (kilowatts)", 
         ylab = "Frequency")
    dev.off()
}
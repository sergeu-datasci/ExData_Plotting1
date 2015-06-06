## Course: Exploratory Data Analysis
## Assignment: Course Project 1
## Task: Draw 3rd plot into plot3.png file
##
## USAGE:
##  1) In terminal, clone the GitHub repository to your computer:
##      git clone https://github.com/sergeu-datasci/ExData_Plotting1.git
##  2) Download and extract household_power_consumption.txt data file into 
##     ExData_Plotting1/data directory.
##  3) In R environment, set the repo directory as your working directory:
##      setwd("path/to/ExData_Plotting1")
##  4) Source plot3.R file:
##      source("plot3.R")
##  5) Run plot3 function:
##      plot3()

plot3 <- function() {
    data <- read_data()
    draw_to_png_3(data)
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
draw_to_png_3 <- function(data) {
    png(filename = "plot3.png", width = 480, height = 480, units = "px")
    plot(data$Time, data$Sub_metering_1, type = "s",
         xlab = "",
         ylab = "Energy sub metering")
    lines(data$Time, data$Sub_metering_2, type = "s", col = "Red")
    lines(data$Time, data$Sub_metering_3, type = "s", col = "Blue")
    legend("topright", lty = rep("solid", 3), col = c("black", "red", "blue"),
           legend = names(data[, c(7:9)]))
    dev.off()
}
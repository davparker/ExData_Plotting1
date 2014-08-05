# Author:   David Parker
# Course:   Exploratory Data Analysis
# School:   John Hopkins University
# Provider: Coursera
# Project:  plot2.R

# clear environment
rm(list=ls())

# read power data
dfpower <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?",
                      colClasses = c("character", "character", "numeric", "numeric", "numeric", 
                                     "numeric", "numeric", "numeric", "numeric"),  stringsAsFactors = FALSE)

# use transform to create a new DateTime field while dropping individual Date & Time fields
dfpower <- transform(dfpower, DateTime = strptime(paste(Date, Time),  "%d/%m/%Y %H:%M:%S"), stringsAsFactors = 0)[, c(10, 3:9)]

# subset results to days 2007-02-01, 2007-02-02
dfpowsub <- dfpower[which(dfpower$DateTime >= "2007-02-01" & dfpower$DateTime < "2007-02-03"), ]


# Plot2 | produce plot2 and copy to plot2.png
par(mar = c(4, 4, 2, 0), oma = c(1, 1, 1, 1))
with(dfpowsub, plot(DateTime, Global_active_power, type = "l", cex.lab = 0.75, cex.axis = 0.75,
                    xlab = "", ylab = "Global Active Power (kilowatts)") )
dev.copy(png, "plot2.png")
dev.off()



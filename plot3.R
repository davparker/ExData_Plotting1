# Author:   David Parker
# Course:   Exploratory Data Analysis
# School:   John Hopkins University
# Provider: Coursera
# Project:  plot3.R

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

# Plot3 | produce plot3 and copy to plot3.png

par(mar = c(3, 4, 2, 0), oma = c(1, 0, 1, 0))
with(dfpowsub, plot(DateTime, Sub_metering_1, type = "l", col = "black", 
                    xlab = "", ylab ="Energy sub metering", cex.axis = 0.75, cex.lab = .75))
with(dfpowsub, lines(DateTime, Sub_metering_2, type = "l", col = "red"))
with(dfpowsub, lines(DateTime, Sub_metering_3, type = "l", col = "blue"))
par(font = 1)
legend("topright", col = c("black", "red", "blue"), cex = 0.7,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1,1))
dev.copy(png, "plot3.png")
dev.off()

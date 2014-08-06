# Author:   David Parker
# Course:   Exploratory Data Analysis
# School:   John Hopkins University
# Provider: Coursera
# Project:  plot4.R

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

# Plot4 | produce plot4 and copy to plot4.png
# plot to screen (for development)
par(mfcol = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 0, 0))
with(dfpowsub, {
  plot(DateTime, Global_active_power, type = "l", cex.lab = 0.75, cex.axis = 0.75,
       xlab = "", ylab = "Global Active Power")
  plot(DateTime, Sub_metering_1, type = "l", col = "black", 
       xlab = "", ylab ="Energy sub metering")
  lines(DateTime, Sub_metering_2, type = "l", col = "red")
  lines(DateTime, Sub_metering_3, type = "l", col = "blue")
  legend("topright", col = c("black", "red", "blue"),  cex = 0.5, bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1))
  plot(DateTime, Voltage, type = "l", cex.lab = 0.75, cex.axis = 0.75, 
       xlab = "datetime")
  plot(DateTime, Global_reactive_power, type = "l", cex.lab = 0.75, cex.axis = 0.75,
       xlab = "datetime")
})

# plot to file
# png("plot4.png", height = 508, width = 508)
png("plot4.png", height = 480, width = 480)
par(mfcol = c(2, 2), mar=c(5.1,4.1,4.1,2.1), oma = c(0, 0, 0, 0))
with(dfpowsub, {
  plot(DateTime, Global_active_power, type = "l",
       xlab = "", ylab = "Global Active Power")
  plot(DateTime, Sub_metering_1, type = "l", col = "black", 
       xlab = "", ylab ="Energy sub metering")
  lines(DateTime, Sub_metering_2, type = "l", col = "red")
  lines(DateTime, Sub_metering_3, type = "l", col = "blue")
  legend("topright", col = c("black", "red", "blue"),  bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1))
  plot(DateTime, Voltage, type = "l",
       xlab = "datetime")
  plot(DateTime, Global_reactive_power, type = "l",
       xlab = "datetime")
})
dev.off()

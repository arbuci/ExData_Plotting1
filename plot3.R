require(dplyr)

file <- "household_power_consumption.txt"
power <- read.delim(file, sep = ";", na.strings = "?")
power$DateTime <- paste(power$Date, power$Time)
power$DateTime <- strptime(power$DateTime, "%d/%m/%Y %H:%M:%S")
power <- power[, 3:10]
startdt <- as.POSIXct("1/2/2007", format = "%d/%m/%Y")
enddt <- as.POSIXct("3/2/2007", format = "%d/%m/%Y")
power$DateTime <- as.POSIXct(power$DateTime)

power <- filter(power, DateTime >= startdt & DateTime < enddt)

png(filename = "plot3.png", width = 480, height = 480)
plot(x = power$DateTime,
     y = power$Sub_metering_1,
     type = "l",
     xlab = NA,
     ylab = "Energy sub metering")
lines(x = power$DateTime,
      y = power$Sub_metering_2,
      type = "l",
      xlab = NA,
      ylab = NA,
      col = "red")
lines(x = power$DateTime,
      y = power$Sub_metering_3,
      type = "l",
      xlab = NA,
      ylab = NA,
      col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lwd = 1)
dev.off()

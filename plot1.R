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

png(filename = "plot1.png", width = 480, height = 480)
hist(power$Global_active_power,
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     main = "Global Active Power")
dev.off()

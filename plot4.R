
## Data URL
data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Download the data
download.file(data_url, destfile = "household_power_consumption.zip")

## Unzip the file
unzip("household_power_consumption.zip")

## Read the data only for dates 01/02/2007 and 02/02/2007 (for windows)
data <- read.table(pipe("findstr /B /R ^[1-2]/2/2007 household_power_consumption.txt"), 
                   sep = ";", na.strings = "?", 
                   col.names = c("Date", "Time", "Global_active_power", 
                                 "Global_reactive_power", "Voltage", 
                                 "Global_intensity", "Sub_metering_1", 
                                 "Sub_metering_2", "Sub_metering_3"))

## Modifying the first two columns and merging them to a single DateTime colummn
data$DateTime <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")


## Creating the png plot
png("plot4.png", width=480, height=480, units="px")
# Plot in four panels various metric changes with time
with(data, {
        par(mfrow = c(2, 2))
        plot(DateTime, Global_active_power, 
             type = "l", xlab = "", ylab="Global Active Power")
        plot(DateTime, Voltage, 
             type = "l", xlab = "datetime", ylab="Voltage")
        plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
        lines(DateTime, Sub_metering_2, col = "red")
        lines(DateTime, Sub_metering_3, col = "blue")
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
               col = c("black", "red", "blue"), lty = 1, bty = "n")
        plot(DateTime, Global_reactive_power, 
             type = "l", xlab = "datetime")
})
dev.off()
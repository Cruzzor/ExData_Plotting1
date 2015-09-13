library(dplyr)
library(tidyr)

## Read/filter data
data <- read.csv("household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep = ";")
mydata <- data %>% filter(Date == "1/2/2007" | Date == "2/2/2007")

##change locale to english for proper x-axis labeling
original_locale <- Sys.getlocale(category = "LC_TIME")
Sys.setlocale(category = "LC_TIME", locale = "English")

## Convert columns 
mydata$Time <- strptime(paste(mydata$Date, mydata$Time), "%d/%m/%Y %H:%M:%S")
mydata$Global_active_power <- as.numeric(mydata$Global_active_power)
mydata$Global_reactive_power <- as.numeric(mydata$Global_reactive_power)
mydata$Voltage <- as.numeric(mydata$Voltage)
mydata$Sub_metering_1 <- as.numeric(mydata$Sub_metering_1)
mydata$Sub_metering_2 <- as.numeric(mydata$Sub_metering_2)
mydata$Sub_metering_3 <- as.numeric(mydata$Sub_metering_3)

## Open png device for plotting
png(file = "plot4.png", width = 480, height = 480)

## Init Parameters
par(col = "black", mfrow = c(2, 2))


######## First Diagram ########
## Create empty diagram
plot(mydata$Time, mydata$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power")

## Plot graph
lines(mydata$Time, mydata$Global_active_power)


######## Second Diagram ########
## Create empty diagram
plot(mydata$Time, mydata$Voltage, type = "n", xlab = "datetime", ylab = "Voltage")

## Plot graph
lines(mydata$Time, mydata$Voltage)


######## Third Diagram ########
## Create empty diagram
plot(mydata$Time, mydata$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1, 1, 1))

## Draw black graph
lines(mydata$Time, mydata$Sub_metering_1)

## Draw red graph
par(col = "red")
lines(mydata$Time, mydata$Sub_metering_2)

## Draw blue graph
par(col = "blue")
lines(mydata$Time, mydata$Sub_metering_3)


######## Fourth Diagram ########
## Change Color back to black
par(col = "black")

## Create empty diagram
plot(mydata$Time, mydata$Global_reactive_power, type = "n", xlab = "datetime", ylab = "global_reactive_power")

## Plot graph
lines(mydata$Time, mydata$Global_reactive_power)


#change locale back to the original setting
Sys.setlocale(category = "LC_TIME", locale = original_locale)

## Close png device
dev.off()
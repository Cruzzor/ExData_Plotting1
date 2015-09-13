library(dplyr)
library(tidyr)

## Read/filter data
data <- read.csv("household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep = ";")
mydata <- data %>% filter(Date == "1/2/2007" | Date == "2/2/2007")

## Convert columns 
mydata$Global_active_power <- as.numeric(mydata$Global_active_power)
mydata$Date <- as.Date(mydata$Date, format = "%d/%m/%Y")

## Open png device for plotting
png(file = "plot1.png", width = 480, height = 480)

## Init Parameters
par(col = "black", mfrow = c(1, 1))

## Plot data
hist(mydata$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")

## Close png device
dev.off()

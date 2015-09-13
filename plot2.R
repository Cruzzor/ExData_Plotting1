library(dplyr)
library(tidyr)

## Read/filter data
data <- read.csv("household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep = ";")
mydata <- data %>% filter(Date == "1/2/2007" | Date == "2/2/2007")

##change locale to english for proper x-axis labeling
original_locale <- Sys.getlocale(category = "LC_TIME")
Sys.setlocale(category = "LC_TIME", locale = "English")

## Convert columns
mydata$Global_active_power <- as.numeric(mydata$Global_active_power)
mydata$Time <- strptime(paste(mydata$Date, mydata$Time), "%d/%m/%Y %H:%M:%S")
mydata$Date <- as.Date(mydata$Date, format = "%d/%m/%Y")

## Open png device for plotting
png(file = "plot2.png", width = 480, height = 480)

## Init Parameters
par(col = "black", mfrow = c(1, 1))

## Create empty diagram
plot(mydata$Time, mydata$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")

## Plot graph
lines(mydata$Time, mydata$Global_active_power)

#change locale back to the original setting
Sys.setlocale(category = "LC_TIME", locale = original_locale)

## Close png device
dev.off()
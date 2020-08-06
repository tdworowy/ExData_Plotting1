install.packages("dplyr")
library(dplyr)

dir.create("Data")

data_set_url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(data_set_url, "household_power_consumption.zip")
unzip("household_power_consumption.zip",exdir="Data")

data <- read.table("Data/household_power_consumption.txt", header = TRUE, sep = ";", dec = ".",
                   colClasses=c("character","character",rep("numeric",7)),na.strings = "?")

data <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")

data["Date"] <-  as.Date(data$Date,'%d/%m/%Y')
temp <- paste(data$Date, data$Time)
data$Time <- strptime(temp, format = "%Y-%m-%d %H:%M:%S")

plot(x = data$Time, y = data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.copy(jpeg,filename="plot2.jpg")
dev.off()
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

par(mfrow = c(2,2))

with(data,{
  plot(x = Time, y = Global_active_power, type = "l", xlab = "", ylab = "Global Avtive Power")
  plot(x = Time, y =Voltage, type = "l", xlab = "datatime", ylab = "Voltage")
  
  plot(x = Time, y = Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub mering")
  lines(x=Time, y = Sub_metering_2, type="l", col = "red")
  lines(x=Time, y = Sub_metering_3, type="l", col = "blue")
  
  legend("topright", lty = "solid", col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
  
  plot(x = Time, y = Global_reactive_power, type = "l", xlab = "datatime", ylab = "Global_reactive_power")
  })

dev.copy(jpeg,filename="plot4.jpg")
dev.off()
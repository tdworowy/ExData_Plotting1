dir.create("Data")

data_set_url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(data_set_url, "household_power_consumption.zip")
unzip("household_power_consumption.zip",exdir="Data")

data <- read.table("Data/household_power_consumption.txt", header = TRUE, sep = ";", dec = ".",
                   colClasses=c("character","character",rep("numeric",7)),na.strings = "?")


hist(data$Global_active_power, col="red", 
     main="Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.copy(jpeg,filename="plot1.jpg")
dev.off()
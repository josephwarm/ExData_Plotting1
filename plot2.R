# read subset of file using sqldf
library(sqldf)
electricPowerConsumption <- read.csv.sql("household_power_consumption.txt", 
                            sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", 
                            header = TRUE, 
                            sep = ";")

# convert Data/Time column to date/time classes
electricPowerConsumption$Time <- paste(electricPowerConsumption$Date, electricPowerConsumption$Time)
electricPowerConsumption$Date <- as.Date(electricPowerConsumption$Date, "%d/%m/%Y")
electricPowerConsumption$Time <- strptime(electricPowerConsumption$Time, "%d/%m/%Y %H:%M:%S")

# open png file
png(filename = "figure\\plot2.png", 
    width = 480,
    height = 480,
    units = "px")

# plot the data
plot(electricPowerConsumption$Time, electricPowerConsumption$Global_active_power,
     'l', 
     ylab = "Global Active Power (kilowatts)", 
     xlab = "")

# close the device
dev.off()
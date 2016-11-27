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
png(filename = "figure\\plot3.png", 
    width = 480,
    height = 480,
    units = "px")

# plot the data
plot(electricPowerConsumption$Time, 
     electricPowerConsumption$Sub_metering_1, 
     'n', 
     ylab = "Energy sub metering", xlab = "")

# add Sub_metering_1
points(electricPowerConsumption$Time,
     electricPowerConsumption$Sub_metering_1,
     'l',
     col = "black")

# add Sub_metering_2
points(electricPowerConsumption$Time,
     electricPowerConsumption$Sub_metering_2,
     'l',
     col = "red")

# add Sub_metering_3
points(electricPowerConsumption$Time,
     electricPowerConsumption$Sub_metering_3,
     'l',
     col = "blue")

# add legend
legend("topright", 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1, 1, 1))

# close the device
dev.off()
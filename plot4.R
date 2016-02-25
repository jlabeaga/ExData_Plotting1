## ===========================================
## Step 1: Read and manipulate data
## ===========================================

# we use the dplyr package for data manipulation
library(dplyr)

# read all the input data
hpc <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?", stringsAsFactors = FALSE)

# convert the Time column to the R POSIXct class
hpc <- mutate(hpc, Time = as.POSIXct(strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S")))

# convert the Date column to the R Date class
hpc <- mutate(hpc, Date = as.Date(Date, "%d/%m/%Y"))

# select only the rows for dates between Thu 2007-02-01 and Fri 2007-02-02
hpc <- filter(hpc, Date >= as.Date("01/02/2007", "%d/%m/%Y") & Date < as.Date("03/02/2007", "%d/%m/%Y") )

## ===========================================
## Step 2: Create the plot layout
## ===========================================

# create the device for 480 x 480 pixels
png(file = "plot4.png", width = 480, height = 480)

# layout = 2 x 2
par(mfrow = c(2, 2))

## ===========================================
## Step 3: Plot 1/4
## ===========================================

plot(hpc$Time, hpc$Global_active_power, type="l", xlab = "", ylab = "Global Active Power")

## ===========================================
## Step 4: Plot 2/4
## ===========================================

plot(hpc$Time, hpc$Voltage, type="l", xlab = "datetime", ylab = "Voltage")

## ===========================================
## Step 5: Plot 3/4
## ===========================================

# create the plot and add the Sub_metering_1 line (black color)
plot(hpc$Time, hpc$Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering")
# add the Sub_metering_1 line (black color)
points(hpc$Time, hpc$Sub_metering_1, col = "black", type = "l")
# add the Sub_metering_2 line (red color)
points(hpc$Time, hpc$Sub_metering_2, col = "red", type = "l")
# add the Sub_metering_3 line (blue color)
points(hpc$Time, hpc$Sub_metering_3, col = "blue", type = "l")
# add the legend
legend("topright", pch = c("_", "_", "_"), bty = "n", cex = 1, pt.cex = 1.5, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## ===========================================
## Step 6: Plot 4/4
## ===========================================

plot(hpc$Time, hpc$Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power", ylim = c(0.0, 0.5))

# close the device
dev.off()

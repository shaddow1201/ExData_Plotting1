#####
##  Coding to create plot4.png
##
##  Details: reads data from current directory file
##    household_power_consumption.txt
##    csv and processes, and writes out plot1.png
#####
# NOTE: Assumes data file is in current working directory
mydata <- read.csv("household_power_consumption.txt",sep=";")

#subset data based on date field
mydata <- mydata[mydata$Date == "1/2/2007" | mydata$Date == "2/2/2007",]

row.has.na <- apply(mydata, 1, function(x){any(x=="?")})
mydata <- mydata[!row.has.na,]

# make column that is easy to read so that format can be built.
mydata$TimeStampbase <- paste(mydata$Date, mydata$Time, sep=" ")
# set timestamp
mydata$datetime <- as.POSIXct(mydata$TimeStampbase,format="%d/%m/%Y %H:%M:%S")

# clean these two up as are in diff format and return incorrect data w/o as.char
mydata$Sub_metering_1 <- as.numeric(as.character(mydata$Sub_metering_1))
mydata$Sub_metering_2 <- as.numeric(as.character(mydata$Sub_metering_2))
# numeric conversion
mydata$Sub_metering_3 <- as.numeric(mydata$Sub_metering_3)
mydata$Global_active_power <- as.numeric(mydata$Global_active_power)
mydata$Voltage <- as.numeric(as.character(mydata$Voltage))
mydata$Global_reactive_power <-as.numeric(as.character(mydata$Global_reactive_power))
                             
#generate output file
png(filename = "plot4.png", width=480, height=480, units="px")
par(mfrow=c(2,2), mfcol=c(2,2))
plot(mydata$datetime, mydata$Global_active_power/500, type="l", ylab="Global Active Power", xlab="", lwd=1)
plot(mydata$datetime, mydata$Sub_metering_1, col="black", type="l", ylab="Energy sub metering", xlab="", lwd=1 )
lines(mydata$datetime, mydata$Sub_metering_2, col='red', type="l", lwd=1)
lines(mydata$datetime, mydata$Sub_metering_3, col='blue', type="l", lwd=1)
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"), bty="n", cex=0.9)
plot(mydata$datetime, mydata$Voltage, type="l", ylab="Voltage", xlab="datetime", lwd=1)
plot(mydata$datetime,mydata$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power", lwd=0.25, cex.lab=0.8, cex.axis=0.8)
dev.off()
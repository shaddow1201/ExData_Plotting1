#####
##  Coding to create plot3.png
##
##  Details: reads data from current directory file
##    household_power_consumption.txt
##    csv and processes, and writes out plot1.png
#####
#load data from text file with ";" seperator  
mydata <- read.csv("household_power_consumption.txt",sep=";")

#subset data based on date field
mydata <- mydata[mydata$Date == "1/2/2007" | mydata$Date == "2/2/2007",]

row.has.na <- apply(mydata, 1, function(x){any(x=="?")})
mydata <- mydata[!row.has.na,]

# make column that is easy to read so that format can be built.
mydata$TimeStampbase <- paste(mydata$Date, mydata$Time, sep=" ")
# set timestamp
mydata$TimeStamp <- as.POSIXct(mydata$TimeStampbase,format="%d/%m/%Y %H:%M:%S")

# clean these two up as are in diff format and return incorrect data w/o as.char
mydata$Sub_metering_1 <- as.numeric(as.character(mydata$Sub_metering_1))
mydata$Sub_metering_2 <- as.numeric(as.character(mydata$Sub_metering_2))
mydata$Sub_metering_3 <- as.numeric(mydata$Sub_metering_3)

# generate output file
png(filename = "plot3.png", width=480, height=480, units="px")
plot(mydata$TimeStamp, mydata$Sub_metering_1, col="black", type="l", ylab="Energy sub metering", xlab="" )
lines(mydata$TimeStamp, mydata$Sub_metering_2, col='red', type="l")
lines(mydata$TimeStamp, mydata$Sub_metering_3, col='blue', type="l")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))

dev.off()
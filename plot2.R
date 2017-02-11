#####
##  Coding to create plot2.png
##
##  Details: reads data from current directory file
##    household_power_consumption.txt
##    csv and processes, and writes out plot1.png
#####
# load data from text file with ";" seperator  
mydata <- read.csv("household_power_consumption.txt",sep=";")

# subset data
mydata <- mydata[mydata$Date == "1/2/2007" | mydata$Date == "2/2/2007",]

# get rid of NA's/invalid values
row.has.na <- apply(mydata, 1, function(x){any(x=="?")})
mydata <- mydata[!row.has.na,]

# set timestamp
mydata$TimeStampbase <- paste(mydata$Date, mydata$Time, sep=" ")
mydata$TimeStamp <- as.POSIXct(mydata$TimeStampbase,format="%d/%m/%Y %H:%M:%S")

## data conversion to numeric
mydata[,3] <- as.numeric(mydata[,3])

# create file output
png(filename = "plot2.png", width=480, height=480, units="px")
plot(mydata$TimeStamp, mydata$Global_active_power/500, type="l", ylab="Global Active Power (kilowatts)", xlab="", cex.lab=0.9)
dev.off()


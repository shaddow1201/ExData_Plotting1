#####
##  Coding to create plot1.png
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

# change factor to date type
mydata[,1] <- as.Date(mydata[,1], "%d/%m/%Y")
# set column as numeric for plotting
mydata[,3] <- sapply(mydata[,3], as.numeric)

# produce output file
png(filename = "plot1.png", width=480, height=480, units="px")
hist(mydata$Global_active_power/500, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()


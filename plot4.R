colNames <- c("Date","Time","PAct","PRea","Volt","Current","Sub1","Sub2","Sub3")

filename <- "household_power_consumption.txt"

# Fetch data from the web? For the script to be self-contained, set to TRUE;
# to save bandwidth, download the file once, unzip, store the file to the
# current directory, and set to FALSE.
fetch_data_from_web <- FALSE

if (fetch_data_from_web) {
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  temp <- tempfile()
  download.file(url, temp)
  d <- read.csv(unz(temp, filename),
                sep=';', col.names=colNames, na.strings="?")
  unlink(temp)
} else {
  d <- read.csv(filename,
                sep=';', col.names=colNames, na.strings="?")
}

d <- subset(d, d$Date=="1/2/2007" | d$Date=="2/2/2007")

d$DateTime <- paste(d$Date,d$Time)
d$Timestamp <- strptime(d$DateTime, format="%d/%m/%Y %H:%M:%S")

png(file="plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# Plot 1
plot(d$Timestamp,
     d$PAct,
     type="l",
     xlab="",
     ylab="Global Active Power")

plot(d$Timestamp,
     d$Volt,
     type="l",
     xlab="datetime",
     ylab="Voltage")

plot(d$Timestamp, d$Sub1,
     type="n",
     xlab="",
     ylab="Energy sub metering")
lines(d$Timestamp, d$Sub1)
lines(d$Timestamp, d$Sub2, col="red")
lines(d$Timestamp, d$Sub3, col="blue")
legend("topright",
       col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1)

plot(d$Timestamp,
     d$PRea,
     type="l",
     xlab="datetime",
     ylab="Global_reactive_power")

dev.off()

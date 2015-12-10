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

png(file="plot2.png", width=480, height=480)
plot(d$Timestamp,
     d$PAct,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")
dev.off()

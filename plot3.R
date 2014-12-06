
library(data.table)

filename <- "household_power_consumption.txt"
doplot3 <- function() {
    if (!file.exists(filename)) {
        loadfile()
    }
    data <- readData()
    plot3(data)
}

loadfile <- function() {
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, destfile = "exdata_data_household_power_consumption.zip", method = "curl")
    unzip("exdata_data_household_power_consumption.zip")
}

readData <- function() {
    from <- grep("^1/2/2007", readLines(filename))
    to <- grep("^3/2/2007", readLines(filename))
    norows <- to[1]-from[1]
    theColNames <- read.table(filename, header=TRUE, sep=";", nrows = 1)
    data <- read.table(filename, sep=";", skip=from[1]-1, nrows=norows, na.strings = "?")
    colnames(data) <- colnames(theColNames)
    data$Date <- as.Date(data$Date, "%d/%m/%Y")
    data$Time <- strptime(paste(data$Date,data$Time), format="%Y-%m-%d %H:%M:%S")
    data
}


plot3 <- function(data) {
    png(filename="plot3.png")
    plot3win(data)
    dev.off()
}

plot3win <- function(data) {
    Sys.setlocale("LC_TIME", "C")
    with(data, plot(Time, Sub_metering_1, ylab="Energy sub metering", xlab="", type="l"))
    with(data, points(Time, Sub_metering_2, col="red", type="l"))
    with(data, points(Time, Sub_metering_3, col="blue", type="l"))
    legend("topright", lwd = 2, pch=NA, col=c("black", "red", "blue"),
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
}

doplot3()
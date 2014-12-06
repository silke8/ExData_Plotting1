
library(data.table)

doplot1 <- function() {
    loadfile()
    data <- readData()
    plot1(data)
}

loadfile <- function() {
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, destfile = "exdata_data_household_power_consumption.zip", method = "curl")
    unzip("exdata_data_household_power_consumption.zip")
}

readData <- function() {
    filename <- "household_power_consumption.txt"
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


plot1 <- function(data) {
    png(filename="plot1.png")
    hist(data$Global_active_power, xlab="Global Active Power (kilowatts)", main = "Global Active Power", col="red")
    dev.off()
}

plot1win <- function(data) {
    hist(data$Global_active_power, xlab="Global Active Power (kilowatts)", main = "Global Active Power", col="red")
    dev.copy(png, file="plot1win.png")
    dev.off()
}

doplot1()
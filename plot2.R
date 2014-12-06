
library(data.table)

filename <- "household_power_consumption.txt"
doplot2 <- function() {
    if (!file.exists(filename)) {
        loadfile()
    }
    data <- readData()
    plot2(data)
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


plot2 <- function(data) {
    png(filename="plot2.png")
    plot2win(data)
    dev.off()
}

plot2win <- function(data) {
    Sys.setlocale("LC_TIME", "C")
    with(data, plot(Time, Global_active_power, ylab="Global Active Power (kilowatts)", xlab="", type="l"))
}

doplot2()
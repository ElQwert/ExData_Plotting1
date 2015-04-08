
#-Load libraries-
library(dplyr)
library(lubridate)
library(datasets)

# Download and unpack data
file <- "household_power_consumption.txt"
if(!file.exists(file)) {
        cat("Downloading...")
        handle <- tempfile()
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", handle)
        file <- unzip(handle)
        unlink(handle)
}

#-Load data-
cat("Loading file...")
power <- read.table(file, header = T, sep = ';', na.strings = '?')

# Filter it to keep only dates 2007-02-01 and 2007-02-02
cat("Filtering...")
x <- power %>% mutate(datetime = dmy_hms(paste(Date, Time, sep=' '))) %>%
        filter(as.Date(datetime) >= as.Date('2007-02-01'), as.Date(datetime) <= as.Date('2007-02-02'))

# Create PNG and save histogram in to it
cat("Plotting...")
png(filename = "plot2.png", width = 480, height = 480, units = "px", res = 70)
with(x, {
        plot(datetime, Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
        lines(datetime, Global_active_power, col = "black")
})
dev.off()
cat("Done!")
cat("plot2.png was saved to the working directory - ", getwd())



# README (Very Important!)

# It turns out the file of each plot provided by the course for this assignment
# is transparent. 
# That is, the background is not actually white, but completely transparent.

# It can be seen if you right-click on them and click open or view image 
# on the options (there will be tell-tale signs), or 
# if you download and open the files.

# For the sake of replicating the plots exactly, I set the background of the
# plots as transparent here.

# END OF README


# Let us import the data set first.

# Download the file first...(if you use Mac, might need to add method = "curl")
# Tested in Windows, inspiration from peer-assignments I have graded previously

if(!file.exists("household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
  unzip("household_power_consumption.zip", "household_power_consumption.txt")
  file.remove("household_power_consumption.zip")
}

# Retrieve header names from the data set file
# Important, as we will only import the relevant rows from the data set file
# (save our RAM :)

header <- colnames(read.table("household_power_consumption.txt", header = TRUE, sep = ";", nrows = 1))

# Specify the expected classes of the data set columns
# Broken down into two lines to keep the code width under control whenever possible
# Note the first two columns, we'll convert them properly after importing them

dataclass <- c("character", "character", "numeric", "numeric", "numeric")
dataclass <- c(dataclass, "numeric", "numeric", "numeric", "numeric")

# Import the actual data set for 1/2/2007 - 2/2/2007

data <- read.table("household_power_consumption.txt", col.names = header, sep = ";", skip = 66637, nrows = 2880, colClasses = dataclass)

# Convert the date and time into Date/Time class in R
# They are converted into a single vector because the Time column would
# default to today's time otherwise...(and because I like them that way)

# Note that I also took care to convert them to the original timezone!

Date_time <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S", tz ="Europe/Paris")

# Combine the conversion result with the original data set
# Replacing the Date and Time column with Date_time column while at it

data <- cbind(Date_time, data[,3:9])


# Now, actual plot-related code below...

# Open the graphics device first
# Actually the default is already 480*480, but I'll specify them manually too

png(file = "plot3.png", width = 480, height = 480)

# Set background color to transparent (see README comment above)

par(bg = "transparent")

# Create the plot (since it's written, in as short function call as possible!)

with(data, plot(Date_time, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
with(data, lines(Date_time, Sub_metering_1, col = "black"))
with(data, lines(Date_time, Sub_metering_2, col = "red"))
with(data, lines(Date_time, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 1)

# Close our graphics device

dev.off()


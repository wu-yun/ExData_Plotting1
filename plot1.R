##Download and unzip the data package at current working directory
#if data is already downloaded,unziped at current working directory, please skip
#this first three steps
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,dest="dataset.zip")
unzip("dataset.zip")

#read the file, make some conversions, select target data, 
dataset <- read.table("household_power_consumption.txt", header= TRUE, sep=";",na.strings="?")
dataset$Date <- paste(dataset$Date,dataset$Time,sep=" ")
dataset <-dataset[,names(dataset)!="Time"]
dataset$Date <- strptime(dataset$Date, "%d/%m/%Y %H:%M:%S")
colnames(dataset)[1] <-"datetime"
startTime <- strptime("2007-02-01 0:00:00","%Y-%m-%d %H:%M:%S")
endTime <- strptime("2007-02-02 24:00:00","%Y-%m-%d %H:%M:%S")
selectedData <- dataset[which(dataset$datetime > startTime & dataset$datetime < endTime),]

# start the plot, saved as "plot1.png" in current working directory
hist(selectedData$Global_active_power,xlab="Global Active Power (kilowatts)",main="Global Active Power",col="red")
dev.copy(png,file="plot1.png",width= 480, height=480)
dev.off()

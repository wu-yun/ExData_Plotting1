##Download and unzip the data package at current working directory
#if data is already downloaded,unzip at current working directory, please skip
#this first three steps
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,dest="dataset.zip")
unzip("dataset.zip")

#read the file, make some conversions, select target data
dataset <- read.table("household_power_consumption.txt", header= TRUE, sep=";",na.strings="?")
dataset$Date <- paste(dataset$Date,dataset$Time,sep=" ")
dataset <-dataset[,names(dataset)!="Time"]
dataset$Date <- strptime(dataset$Date, "%d/%m/%Y %H:%M:%S")
colnames(dataset)[1] <-"datetime"
startTime <- strptime("2007-02-01 0:00:00","%Y-%m-%d %H:%M:%S")
endTime <- strptime("2007-02-02 24:00:00","%Y-%m-%d %H:%M:%S")
selectedData <- dataset[which(dataset$datetime > startTime & dataset$datetime < endTime),]

# start the plot, saved as "plot2.png" in current working directory
y1 <-selectedData$Sub_metering_1
y2 <-selectedData$Sub_metering_2
y3 <-selectedData$Sub_metering_3
x <- selectedData$datetime
par(mfrow=c(2,2))
with(selectedData,{
	plot(datetime,Global_active_power,ylab="Global Active Power",type="l",xlab="")
	plot(datetime,Voltage,type="l")
	plot(range(x),range(y1,y2,y3),type="n",ylab="Energy sub metering",xlab="")
	lines(x, y1,col="black")
	lines(x, y2,col="red")
	lines(x, y3,col="blue")
	legend("topright",lty=1,cex=0.5,bty="n",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
	plot(datetime,Global_reactive_power,type="l")
	})
dev.copy(png,file="plot4.png",width= 480, height=480)
dev.off()
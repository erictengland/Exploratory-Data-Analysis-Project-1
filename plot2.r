# Data downloading and processing.
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.csv(unz(temp, "household_power_consumption.txt"),sep=";")
unlink(temp)
rm(temp)
subset1<-data[data$Date=="1/2/2007",]
subset2<-data[data$Date=="2/2/2007",]
subset<-rbind(subset1,subset2)
rm(data)
texttonum <- function(x){return(as.double(as.character(x)))}
subset[,3:9]<-lapply(subset[,3:9], texttonum)
texttodate <-function(x){return(as.Date(x,"%d/%m/%Y"))}
subset$PosixDate<-sapply(subset[,1],texttodate)
x<-paste(subset[,1],subset[,2])
datetime<-as.POSIXlt(character())
for (i in 1:2880)
{
  datetime[i]<-as.POSIXlt(strptime(x[i], "%d/%m/%Y %H:%M:%S"))
}
# End of data processing
#Begin actual graphics work
png(filename="plot2.png")
plot(datetime,subset$Global_a,pch="",type="o",yaxt="n",ylim=c(0,8),xlab="",ylab="Global Active Power (kilowatts)")
axis(side=2,at=c(0,2,4,6))
dev.off()
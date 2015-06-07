# Data downloading and processing
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.csv(unz(temp, "household_power_consumption.txt"),sep=";")
unlink(temp)
rm(temp)
subset1<-data[data$Date=="2/1/2007",]
subset2<-data[data$Date=="2/2/2007",]
subset<-rbind(subset1,subset2)
rm(data)
texttonum <- function(x){return(as.double(as.character(x)))}
subset[,3:9]<-lapply(subset[,3:9], texttonum)
texttodate <-function(x){return(as.Date(x,"%m/%d/%Y"))}
subset$PosixDate<-sapply(subset[,1],texttodate)
x<-paste(subset[,1],subset[,2])
datetime<-as.POSIXlt(character())
for (i in 1:2880)
{
  datetime[i]<-as.POSIXlt(strptime(x[i], "%m/%d/%Y %H:%M:%S"))
}
# End of data processing
#Begin actual graphics work
png(filename="plot3.png")
plot(datetime,subset$Sub_metering_3,type="o",pch="",xlab="",
     col="blue", ylab="Energy Sub Metering",ylim=c(0,30))
points(datetime,subset$Sub_metering_2,type="o",pch="",col="red")
points(datetime,subset$Sub_metering_1,type="o",pch="")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex=0.8, 
       col=c("black","red","blue"), pch="", lty=1,bty="n")
dev.off()
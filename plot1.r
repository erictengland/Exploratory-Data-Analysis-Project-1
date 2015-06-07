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
datetime<-list()
for (i in 1:2880)
{
  datetime[[i]]<-(strptime(x[i], "%m/%d/%Y %H:%M:%S"))
}
# End of data processing
#Begin actual graphics work
png(filename="plot1.png")

hist(as.numeric(as.character(subset$Global_a)), 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     col="red", 
     xlim=c(0,6), 
     breaks<-c(0:16)/2,
     right=FALSE,
     xaxt="n",yaxt="n",
     mai=c(2,2,2,2),
     ylim=c(0,1400) )
axis(side=1,at=c(0,2,4,6))
axis(side=2,at=c(0,200,400,600,800,1000,1200))
dev.off()
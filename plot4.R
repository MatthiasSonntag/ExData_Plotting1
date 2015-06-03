library(data.table) 
# Read date every column in character format
powerconsumption <- fread("~/datasciencecoursera/household_power_consumption.txt"
                          , colClasses=c(rep("character",9)), showProgress=T)

# Exchange ? for NAs
powerconsumption[powerconsumption == "?"] <- NA

# Change class of date from character to date 
powerconsumption[, Date:=as.Date(Date,"%d/%m/%Y" )]

# Get the date between 2007-02-01 and 2007-02-01
powerconsumption <- powerconsumption[Date >=as.Date("2007-02-01") ]
powerconsumption <- powerconsumption[Date <=as.Date("2007-02-02") ]

# Sort by Date and timeseries to get data in right order
setkey(powerconsumption,Date,Time)

# Change the Global power variables the Voltage variable and 
# Sub_metering variables from class character to class numeric
powerconsumption[, c(3,4,5,7,8,9):=lapply(.SD,as.numeric), .SDcols=c(3,4,5,7,8,9)]

# Plot png with for subplots
png("plot4.png",width = 480, height = 480)
par(mfcol=c(2,2))

# First subplot
powerconsumption[,{plot(Global_active_power, 
      type="l", ylab="Global Active Power",xlab="",xaxt="n")
      axis(1,c(0,1440,2880),c("Thu","Fri","Sat"))}]

# Second subplot
powerconsumption[,{plot(Sub_metering_1, col=1,
                        type="l", ylab="Energy sub metering",xlab="",xaxt="n")
lines(Sub_metering_2, col=2)
lines(Sub_metering_3, col=4)
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
      lty=c(1,1,1), col=c(1,2,4),bty="n")
      axis(1,c(0,1440,2880),c("Thu","Fri","Sat"))}]

# Third subplot
powerconsumption[,{plot(Voltage, col=1,
      type="l", ylab="Voltage",xlab="datetime",xaxt="n")
      axis(1,c(0,1440,2880),c("Thu","Fri","Sat"))}]

# Forth subplot
powerconsumption[,{plot(Global_reactive_power, col=1,lwd=.5,
      type="l", ylab="Global_reactive_power",xlab="datetime",xaxt="n")
      axis(1,c(0,1440,2880),c("Thu","Fri","Sat"))}]
dev.off()





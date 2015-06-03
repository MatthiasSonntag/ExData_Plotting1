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

# Change the Sub_metering variables from class character to class numeric
#cols <- c("Sub_metering_1", "Sub_metering2","Sub_metering_3")
powerconsumption[, c(7,8,9):=lapply(.SD,as.numeric), .SDcols=c(7,8,9)]
                   
# Plot png without x-axis and add day x-axis
png("plot3.png",width = 480, height = 480)
powerconsumption[,{plot(Sub_metering_1, col=1,
     type="l", ylab="Energy sub metering",xlab="",xaxt="n")
     
# Add the other Sub_metering graphs    
lines(Sub_metering_2, col=2)
lines(Sub_metering_3, col=4)
# Add legend
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c(1,2,3))
axis(1,c(0,1440,2880),c("Thu","Fri","Sat"))}]
dev.off()
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

# Change the Variable from class character to class numeric
powerconsumption[,Global_active_power:=as.numeric(Global_active_power)]

# Plot png without x-axis and add day x-axis later
png("plot2.png",width = 480, height = 480)
powerconsumption[,{plot(Global_active_power, 
    type="l", ylab="Global Active Power (kilowatts)",xlab="",xaxt="n")
    axis(1,c(0,1440,2880),c("Thu","Fri","Sat"))}]
dev.off()
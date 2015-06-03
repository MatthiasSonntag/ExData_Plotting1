library(data.table) 
# Read date every column in character format
powerconsumption <- fread("~/datasciencecoursera/household_power_consumption.txt"
                          , colClasses=c(rep("character",9)), showProgress=T)

# Exchange ? for NAs
powerconsumption[powerconsumption == "?"] <- NA

# Change class of date from character to date
powerconsumption[, Date:=as.Date(Date,"%d/%m/%Y" )]
#set(powerconsumption, j=col, value=as.Date(dt[[col]],"%d/%m/%Y"))
setkey(powerconsumption,Date)

# Get the date between 2007-02-01 and 2007-02-01
powerconsumption <- powerconsumption[Date >=as.Date("2007-02-01") ]
powerconsumption <- powerconsumption[Date <=as.Date("2007-02-02") ]

# Change the Variable from class character to class numeric
powerconsumption[,Global_active_power:=as.numeric(Global_active_power)]

# Plot histogramm and 
png("plot1.png",width = 480, height = 480)
powerconsumption[,hist(Global_active_power,col=2,
                   xlab="Global Active Power (kilowatts)",
                   main="Global Active Power")]

dev.off()



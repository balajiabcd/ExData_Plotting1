
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
namezip <- "exdata_data_household_power_consumption.zip"
nametxt <- "household_power_consumption.txt"

if (! file.exists(namezip)) {
   download.file(url= url,destfile = namezip)
}

if (! file.exists(nametxt)){
   unzip(namezip)
}


# Readin txt file and changing class of date
df <- read.table("household_power_consumption.txt",header = TRUE,sep = ";",na.strings=c("?"))
df$Date <- as.Date(df$Date,"%d/%m/%Y")


# Subsetting and changing class of Global active power and Time
df <- subset(df, df$Date >= as.Date("01/02/2007","%d/%m/%Y") &
                df$Date <= as.Date("02/02/2007","%d/%m/%Y") , na.rm = TRUE )

df$Time<-strptime(paste(df$Date,df$Time),"%F %T")
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)
df$Global_active_power <- as.numeric(df$Global_active_power)
df$Voltage <- as.numeric(df$Voltage)


# Ploting all four plots in same window
png("plot4.png")
par(mfrow = c(2,2))

#1st plot
plot(df$Time,df$Global_active_power,type = "line",
     xlab = "", ylab = "Global Active Power")


# 2nd plot
plot(df$Time,df$Voltage,type = "l",xlab = "datetime",ylab = "Voltage")


# 3rd plot
plot( df$Time ,df$Sub_metering_1,type = "l",col = "black",xlab = "",ylab = "Energy sub metering")
lines( df$Time ,df$Sub_metering_2,type = "l",col = "red")
lines( df$Time ,df$Sub_metering_3,type = "l",col = "blue")
legend("topright", lwd=1, col=c("black", "red", "blue"), legend=names(df[,7:9]))


# 4th plot
plot(df$Time,df$Global_reactive_power,type = "l",xlab = "datetime",ylab = "Global_reactive_power")


dev.off()


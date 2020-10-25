
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
df$Global_active_power <- as.numeric(df$Global_active_power)
df$Time<-strptime(paste(df$Date,df$Time),"%F %T")


# line plot for Global Active Power and saving as png file
png("plot2.png")
plot(df$Time,df$Global_active_power,type = "line",
     xlab = "", ylab = "Global Active Power")
dev.off()
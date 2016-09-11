library(dplyr)
setwd("C:/Goergi/Coursera/Exploratory_Data_Analysis/week1/ExData_Plotting1")
Sys.setlocale("LC_ALL","English") #set English locale for plotting

# --- Load Dataset ---
print("Reading Dataset")
#only read data frame if it has not already been read
#helps save time with multiple reruns of this code during programming
if( !exists("powerdata"))
{
    powerdata <- read.csv2("C:/Goergi/Coursera/Exploratory_Data_Analysis/week1/household_power_consumption.txt", colClasses = "character", header = TRUE, na.strings = c("?",""))
    
    print("Subsetting dataset")
    powerdata <- filter(powerdata, Date == "1/2/2007" | Date == "2/2/2007")
    print("Assigning classes")
    #Assign correct classes to dataset
    #Drop the date column and combine date and time to correct value in Time column
    powerdata <- transmute(powerdata, Time=as.POSIXct(strptime(paste(Date, Time),format="%d/%m/%Y %H:%M:%S")), Global_active_power = as.numeric(Global_active_power), Global_reactive_power=as.numeric(Global_reactive_power), Voltage = as.numeric(Voltage), Global_intensity = as.numeric(Global_intensity), Sub_metering_1 = as.numeric(Sub_metering_1), Sub_metering_2=as.numeric(Sub_metering_2), Sub_metering_3 = as.numeric(Sub_metering_3))
}


# --- Make Plot ---

#1. Create a 2x2 plot frame
windows()
par(mfrow=c(2,2))
plotID <- dev.cur()

#2. Now put create all other plots and put them in there

#2.A
with(powerdata,plot(Time, Global_active_power, type="l", xlab = "", ylab ="Global Active Power"))

#2.B
with(powerdata,plot(Time, Voltage, type="l", xlab = "datetime", ylab ="Voltage"))

#2.C (see plot3.R)
with(powerdata,plot(Time, Sub_metering_1, type="l", xlab = "", ylab ="Energy sub metering"))
with(powerdata, lines(Time, Sub_metering_2,col="red"))
with(powerdata, lines(Time, Sub_metering_3, col="blue"))
legend("topright", c("Sub_metering_1 ","Sub_metering_2 ","Sub_metering_3 "), lty=c(1,1,1), col=c("black", "red", "blue"))

#2.D
with(powerdata,plot(Time, Global_reactive_power, type="l", xlab = "datetime"))


# --- Copy to File ---

dev.copy(png, filename = "plot4.png", width = 480, height = 480)
dev.off()
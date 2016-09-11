library(dplyr)
setwd("C:/Goergi/Coursera/Exploratory_Data_Analysis/week1/ExData_Plotting1")

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

#open new graphics device (to bypass RStudio device)
windows()
plotID <- dev.cur()
with(powerdata,hist(Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency" ))
dev.copy(png, filename = "plot1.png", width = 480, height = 480)
dev.off()
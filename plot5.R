# Read in the NEI data
NEI <- readRDS("summarySCC_PM25.rds")

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 
# Get the subset of data for Baltimore City
baltimoreData <- subset(NEI, fips == "24510")
# Get SCC.Level.Three containing word "Vehicle" (convert points to underscores for sqldf)
library(sqldf)
vehicleTypes <- sqldf(
  "select distinct SCC from SCC where SCC_Level_Two like '%Vehicle%'")

# Get the subset of engine-related data from the Baltimore dataset
vehicleData <- subset(baltimoreData, SCC %in% vehicleTypes$SCC)

# Summarise the engine-related data by year
yearTotalsVehicles <- tapply(vehicleData$Emissions, vehicleData$year, sum)

png(file="plot5.png", width = 480, height = 480)

barplot(yearTotalsVehicles, main = "PM2.5 Emissions by Vehicles in Baltimore", 
        xlab = "Year", ylab = "Tons",
        col=2:5, names.arg = names(yearTotalsVehicles))
dev.off()
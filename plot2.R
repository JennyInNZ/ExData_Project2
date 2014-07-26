# Read in the NEI data
NEI <- readRDS("summarySCC_PM25.rds")

# Get the subset of data for Baltimore City
baltimoreData <- subset(NEI, fips == "24510")
baltimoreYearTotals <- tapply(baltimoreData$Emissions, baltimoreData$year, sum)

# Generate the plot
png(file="plot2.png", width = 480, height = 480)

barplot(baltimoreYearTotals, main = "PM2.5 Emissions in Baltimore City", 
        xlab = "Year", ylab = "Tons",
        col=2:5, names.arg = names(baltimoreYearTotals))
dev.off()
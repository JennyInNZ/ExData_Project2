# Read in the NEI data
NEI <- readRDS("summarySCC_PM25.rds")

# Summarise the emissions totals by year
yearTotals <- tapply(NEI$Emissions, NEI$year, sum)

# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.
png(file="plot1.png", width = 480, height = 480)
barplot(yearTotals, main = "PM2.5 Emissions", xlab = "Year", ylab = "Tons",
        col=2:5, names.arg = names(yearTotals))
dev.off()
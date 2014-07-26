# Read in the NEI data
NEI <- readRDS("summarySCC_PM25.rds")

# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-2008?

# Get SCC.Level.Three containing word "Coal" (convert points to underscores for sqldf)
library(sqldf)
coalTypes <- sqldf(
  "select distinct SCC from SCC where SCC_Level_Three like '%Coal%'")

# Get the subset of coal-related data from the NEI dataset
coalData <- subset(NEI, SCC %in% coalTypes$SCC)

# Summarise the coal-related data by year
yearTotalsCoal <- tapply(coalData$Emissions, coalData$year, sum)

png(file="plot4.png", width = 480, height = 480)

barplot(yearTotalsCoal, main = "PM2.5 Emissions from Coal Sources", xlab = "Year", ylab = "Tons",
        col=2:5, names.arg = names(yearTotals))
dev.off()
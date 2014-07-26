# Read in the NEI data
NEI <- readRDS("summarySCC_PM25.rds")

# Get the subset of data for Baltimore City
baltimoreData <- subset(NEI, fips == "24510")

# Use ddply to summarise the emissions by year and type
library(plyr)
baltimoreGroups <- ddply(baltimoreData, c("year","type"), 
                         function(baltimoreData)sum(baltimoreData$Emissions))
names(baltimoreGroups) <-c("Year","Type", "Emissions")

# Use ggplot to plot out the data
library(ggplot2)

# Generate the plot
png(file="plot3.png", width = 480, height = 480)

p <- ggplot(baltimoreGroups, aes(x=Year, y=Emissions, group=Type))
p + geom_line(aes(color=Type))
dev.off()
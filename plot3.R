# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999-2008 
# for Baltimore City? Which have seen increases in emissions from 1999-2008?

# Read in the NEI data
NEI <- readRDS("summarySCC_PM25.rds")

# Set a colourblind-friendly palette
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", 
               "#0072B2", "#D55E00", "#CC79A7")

# Get the subset of data for Baltimore City
baltimoreData <- subset(NEI, fips == "24510")

# Use ddply to summarise the emissions by year and type
library(plyr)
baltimoreGroups <- ddply(baltimoreData, c("year","type"), 
                         function(baltimoreData)sum(baltimoreData$Emissions))
names(baltimoreGroups) <-c("Year","Type", "Emissions")

# Change Year to be a factor so that it plots properly
baltimoreGroups$Year <- factor(baltimoreGroups$Year)

# Use ggplot to plot out the data
library(ggplot2)

# Generate the plot
png(file="plot3.png", width = 480, height = 480)

p <- ggplot(baltimoreGroups, aes(x=Year, y=Emissions, group=Type))
p + geom_line(aes(color=Type)) + 
  ggtitle("Emissions by Source in Baltimore City") # Set title

dev.off()
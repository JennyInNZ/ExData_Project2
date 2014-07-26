# Read in the NEI data
NEI <- readRDS("summarySCC_PM25.rds")

# Set a colourblind-friendly palette
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", 
               "#0072B2", "#D55E00", "#CC79A7")

# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# Get the subset of data for Baltimore City and LA County
bothData <- subset(NEI, fips%in% c("24510", "06037"))
bothData$year <- factor(bothData$year)
names(bothData)

# Create the plot
png(file="plot6.png", width = 480, height = 480)
ggplot(data=bothData, aes(x=year, y=Emissions, fill=fips)) + 
  geom_bar(stat="identity", position="dodge") +
  scale_fill_manual(name="Area", values=cbPalette, 
                    labels=c("LA County", "Baltimore City")) + 
  xlab("Year") + ylab("Emissions") + # Set axis labels
  ggtitle("Baltimore City and LA County") +  # Set title
  theme_bw()
dev.off()


         
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# first I found that which row have emission from coal combustion
w=which(scc$EI.Sector=="Fuel Comb - Comm/Institutional - Coal")

# find corresponding name of the source
x = scc$SCC[w]

# create a data frame 
y = data.frame(x)
y$x = as.character(y$x)
names(y) = "SCC"

# merge that data frame and nei by SCC variable
m = merge(y, nei, by.x = "SCC")

# find the total emission corresponding to each year
t = tapply(m$Emissions, m$year, sum)
dt = data.frame(sum= tapply(m$Emissions, m$year, sum), year= rownames(t))
qplot(year, sum, data = dt, geom = c("point","line"), group = 1, ylab = "emission from coal", col = year)
dev.copy(png, "plot4.png")
dev.off()

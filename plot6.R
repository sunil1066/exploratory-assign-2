nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
s = subset(nei, nei$fips=="24510")
l = subset(nei, nei$fips=="06037")
g= grep("Vehicles", scc$EI.Sector)
z = scc$SCC[g]
z = data.frame(z)
z$z = as.character(z$z)
names(z) = "SCC"

# merge data frame with both city
mer = merge(z, s, by.x = "SCC")
mer1 = merge(z, l, by.x = "SCC")
t = tapply(mer$Emissions, mer$year, sum)

# data frame for baltimore city
dtt = data.frame(sum = t, year=rownames(t))
t1 = tapply(mer1$Emissions, mer1$year, sum)

# data frame for los angeles county
dtt1 = data.frame(sum = t1, year=rownames(t1))

ggplot() + geom_point(data =dtt, aes(x=year, y=sum), col = dtt$year) + geom_point(data = dtt1, aes(x=year, y=sum), col = dtt1$year) + geom_line(data = dtt, aes(x= year, y=sum , group = 1), col = "blue") + geom_line(data = dtt1, aes(x=year, y=sum, group = 1), col = "red") + labs(y="emission from vehicle", title = "Compare emission of Baltimore city and Los angeles county")

dev.copy(png, "plot6.png")
dev.off()


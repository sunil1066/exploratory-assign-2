nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
s = subset(nei, nei$fips=="24510")
g= grep("Vehicles", scc$EI.Sector)
z = scc$SCC[g]
z = data.frame(z)
z$z = as.character(z$z)
names(z) = "SCC"
mer = merge(z, s, by.x = "SCC")
t = tapply(mer$Emissions, mer$year, sum)
dtt = data.frame(sum = t, year=rownames(t))
ggplot(dtt, aes(x=year, y=sum)) + geom_point(col = dtt$year) + geom_line(aes(group=1), col= dtt$year) + labs(y = "emission from vehicle")
dev.copy(png, "plot5.png")
dev.off()

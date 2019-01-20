##LOAD AND SAVE RDATA
#load Rdata
load("D:/SUMMER COURSE/Day-3/Hands-on Practical/HP1-Exploring pollution datasets using R/data/monthlydata.Rdata")
#save Rdata
save(monthyl_data, file="D:/SUMMER COURSE/Day-3/Hands-on Practical/HP1-Exploring pollution datasets using R/data/monthlydata2.Rdata")


##IMPORT EXPORT CSV FILE
#write new variables
var1 <- 1:5
var2 <- (1:5)/10
var3 <- c("R", "Data Mining", "Summer", "Course", "MAPFire")
#combine to data frame
a <- data.frame(var1, var2, var3)
#change header name
names(a) <- c("Variable_Int", "Variable_Real", "Variable_Char")
#export to csv file
write.csv(a,"D:/SUMMER COURSE/Day-3/Hands-on Practical/HP1-Exploring pollution datasets using R/data/dummyData.csv", row.names = FALSE)
#import csv file
b <- read.csv("D:/SUMMER COURSE/Day-3/Hands-on Practical/HP1-Exploring pollution datasets using R/data/dummyData.csv")
print(b)  


##IMPORT AND READ POLLUTANT DATA
library(readr)
dataPollutant<- read.csv("D:/SUMMER COURSE/Day-3/Hands-on Practical/HP1-Exploring pollution datasets using R/data/dataPollutant.csv")
print(dataPollutant)


##STATISTICAL SUMMARY
#summary for whole data
str(dataPollutant)
summary(dataPollutant)
#summary for selected attributes
summary(dataPollutant$co)
summary(dataPollutant$co2)


##OPENAIR
#install
install.packages("openair")
#load library
library("openair")

#change the date format
dataPollutant$date <- as.POSIXct(strptime(dataPollutant$date, format = "%d/%m/%Y"))
#averaging the data
dataPollutant_monthly <- timeAverage(dataPollutant, avg.time = "day", data.thresh = 50)

#plot the data based on its time
timePlot(dataPollutant, pollutant = c("co", "co2", "ch4", "nh3", "pm25"), statistic = "mean", plot.type = "h", lwd = 1.5, lty = 1.5, main = "Timeplot Pollutant Concentration July-November 2015" , ylab = "concentration (ug/m2s)", y.relation = "free")
timePlot(dataPollutant, pollutant = c("co", "co2", "ch4", "nh3", "pm25"), statistic = "max", plot.type = "h", lwd = 1.5, lty = 1.5, main = "Timeplot Pollutant Concentration July-November 2015" , ylab = "concentration (ug/m2s)", y.relation = "free", auto.text = TRUE)

#visualize the data on scatterplot
scatterPlot(dataPollutant, x = "co2", y = "co", method = "hexbin", col= "jet")

#corrgram plot to visualize correlation matrices
corPlot(dataPollutant, pollutants = c("co", "co2", "ch4", "nh3", "pm25"))
corPlot(selectByDate(dataPollutant, day = 11), pollutants = c("co","co2"))

#summary plot to show an overview of the data
summaryplot <- summaryPlot(subset(dataPollutant, select = c(date,co,co2,ch4,nh3,pm25)), type = FALSE, period = "months", main = "Summaryplot Pollutant Concentration July-November 2015")

#plot the data into calendar view to see the concentration of co each day
calendarplot <- calendarPlot(dataPollutant, pollutant = "co", statistic = "max")

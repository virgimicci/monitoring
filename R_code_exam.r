# R_code_exam.r


# Indices
# 1. R_code_first 
# 2. R_code_multipanel 
# 3. R_code_spatial 
# 4. R_code_multivariate 
# 5. R_code_remote_sensing 
# 6. R_code_point_pattern_analysis
# 7. R_code_ecosystem_functioning
# 8. R_code_PCA_remote_sensing 
# 9. R_code_faPAR  
# 10. R_code_radiance 
# 11. R_code_faPAR10
# 12. R_code_EBVs 
# 13. R_code_snow 
# 14. R_code_no2
# 15. R_crop_an_image 
# 16. notes_for_project 
# 17. R_code_temp_interpolation
# 18. R_species_distribution_modelling 

####### 1. R_code_first #######
###############################

# the function install.packages is used to install any packages that we want to use which is still not intalled in our R
#sp is a package for spatial data
install.packages("sp")

# the function library is used to start using the data present in the package
library(sp)
#meuse is a dataset comprising of four heavy metals measured in the top soil in a flood plain along the river Meuse
data(meuse)

# let's see how the meuse dataset is structured
meuse
# let's look at the first rows of the set with the function head()
head(meuse)

#Let's plot two variables
#let's see if zinc concentration is related to that copper
#the function attach () connects the dataset to the r search path so that we can use the infos in the dataset
attach(meuse)
# plot function is used for plotting a dataset
plot(zinc,copper)
# col is used to choose the colour
plot(zinc,copper,col="green")
# pch is used to define the symbol
plot(zinc,copper,col="green",pch=19)
# cex is used to define the size of the symbol
plot(zinc,copper,col="green",pch=19,cex=4)

#### 2. R_code_multipanel ### 
### Multipanel in R: second lecture of monitoring ecosystem

install.packages("sp")
install.packages("GGally") # this is used for the function ggpairs()

library(sp) # require(sp) will also do the job

data(meuse) #there is a dataset aviable named meuse
attach(meuse)

# Excercise: see the names of the variables and plot cadmium versus zinc 
# There are two manners to see the names of the variables:
names(meuse) # is used to see the names of the different variables
head(meuse) # i see just the first six lines

plot(cadmium,zinc,pch=15,col="red",cex=2) 

# Exercise: make all the possible paiwis plots of the dataset
# plot(x,cadmium)
# plot(x,zinc)
# plot....
# plot is not a good idea!

#the function pairs() is used to produce a matrix of scatterplots
pairs(meuse)
# in case you recive the error "the size is too large" reshape with the mouse the graph window

# code to switch from the whole varaiable to the 4 variable
pairs(~ cadmium + copper + lead + zinc, data=meuse)

pairs(meuse[,3:6]) # subset of meuse dataset since column 3 to 6, another way for do it, is like the previews one

# Exercise: prettify the graph
pairs(meuse[,3:6],pch=8,col="purple",cex=2)

# GGally package will prettify the graph
library(GGally)
ggpairs(meuse[,3:6])

####### 3. R_code_spatial  #######
##################################

# R code for spatial view of points

library(sp)
data(meuse)
head(meuse)

# coordinates
# coordinates of this spatial dataset, we have to explain that are under x and y 
coordinates(meuse) = ~x+y # the function coordinates() is to say to R that in the dataset meuse the coordinates are x and y

# we can put a plot for making a graph of the dataset
plot(meuse)
spplot(meuse, "zinc") # the legend is related to the variable, in this case Zinc

# Exercise: plot the spatial amount of copper 
spplot(meuse, "copper", main = "Copper concentration")  # with "main" i create the title of the graph

# We change the way we see the point in the graph with the function bubble
bubble(meuse, "zinc")

# Exercise: bubble copper in red
bubble(meuse, "copper", main = "Copper concentration", col="red")

#### Importing new data
# download covid_agg.csv from our teaching site and build a folder called lab into C:
# put the covid_agg.csv file into the folder lab
# setting the working directory: lab
# Windows
# setwd("C:/lab/")
setwd("C:/lab/")

# the function read.table("covid_agg.csv", head=T) is to open and read the file, with "" because is imported from outside
# <- is to assign to a vector
covid <- read.table("covid_agg.csv", head=TRUE) # it's imp to put the head to insert the title of the column using TRUE
head(covid) 
attach(covid)
plot(country, cases) # where country is x and cases is y

# in case you do not attach covid you should use the dollar, plot(covid$country, covid$cases)

plot(country, cases, las=0) # parallel lables
# we cannot see all the countries so we need to change the orientation of the lables
plot(country, cases, las=1) # horizontal lables
plot(country, cases, las=2) # perpendiicular lables
plot(country, cases, las=3) # vertical lables
plot(country, cases, las=3) 

# we want to reduce the size of the x axis labels using cex.axis and assignin a value lower than 1
plot(country, cases, las=3, cex.axis=0.5)

# ggplot2 package
install.packages("ggplot2")
library(ggplot2) # require(ggplot2)

## save the .RData under the menu File ##

# load the previously saved .RData
setwd("C:/lab/")
load("spatial.RData")
ls() #ls() is the function to check which files are uploaded

# Covid
library(ggplot) #require(ggplot2)
# mpg dataset provides fuel economy data from 1999 and 2008 for 38 popular models of cars. The dataset is shipped with ggplot2 package
data(mpg) #to access to it
head(mpg)
# key components: data, aes, geometry
ggplot(mpg, aes(x=displ, y=hwy)) + geom_point()

# we can change the geometry of the graph 
ggplot(mpg, aes(x=displ, y=hwy)) + geom_line()
ggplot(mpg, aes(x=displ, y=hwy)) + geom_polygon()

#let's look at the covid data that we already have uploaded
head(covid)
# aes= variable we want to plot, size=dimensions of point, geom = geometry of the point
# we will exagerate the size by the number of cases
ggplot(covid, aes(x=lon, y=lat, size=cases)) + geom_point()


####### 4. R_code_multivariate #######
# R code for multivariate analysis
setwd("C:/lab/")

# The vegan package provides tools for descriptive community ecology. It has most basic functions
# of diversity analysis, community ordination and dissimilarity analysis. Most of its multivariate tools
# can be used for other data types as well.
install.packages("vegan")
library(vegan)

# biomes is the name that we give(the vector assigned by the symbol <-), read.table is to analyze the data, "biomes.csv" is the name of the file, 
# head=T because the first row is words, sep="," is the separator between the names of the words in the row
biomes <- read.table("biomes.csv", head=T, sep=",")
head(biomes) # or also view(biomes), biomes

# Multivariate analysis
# DEtrended CORrespondence ANAlysis
multivar <- decorana(biomes)
plot(multivar)
# we are now seeing the graph from 1 point of view, but we can see it from other
#if we just put multivar, we see the analysis that happened
multivar
# eigenvalues= the percentage of data that we are able to see from this prospective

# biomes types
biomes_types <- read.table("biomes_types.csv", header=T, sep=",")
head(byomes_types)
attach(biomes_types)
# we make an ordiellipse that connects all the data. Multivar is the first name we gave
# lwd= thickness of the line with respect to the default thickness 
ordiellipse(multivar, type, col=1:4, kind = "ehull", lwd=3) # we can put the color like this or col=c("green","orange","red","blue")
#to see the 'disk' of the biomes
ordispider(multivar, type, col=1:4, label=T)


####### 5. R_code_remote_sensing #######
########################################

# R code remote sensing, to see things through wave

setwd("C:/lab/")
# raster is useful for reading, writing, manipulating, analyzing and modeling of gridded spatial data (the format with pixels), name derives from rastrum=aratro
install.packages("raster")
#RStoolbox is a package for remote sensing image processing and analysis, such as calculating spectral indices, principal component transformation, unsupervised and supervised classification or fractional cover analyses.
install.packages("RStoolbox")

library(raster) 

# we are going to import some images, since these are satellite images and so they have more layers we use brick
# brick imports different layers at a time like satellites with more bands
# .grd are the images
p224r63_2011 <- brick("p224r63_2011_masked.grd")
plot(p224r63_2011) # we can see the plot of the different reflectance of bands, now we change the color ramp palette
cl <- colorRampPalette(c("black","grey","light grey"))(100)

# Exercise: plot the image with the new color ramp palette
plot(p224r63_2011, col=cl) # using col=cl we use the colors decided in the previous funcion

# Bands of Landsat
# B1: blue
# B2: green
# B3: red
# B4: NIR

# colors()--> shows how many color there are into R
# multiframe of different plots all togheter, (2,2) row per column
par(mfrow=c(2,2))

# B1: blue
clb <- colorRampPalette(c('dark blue', 'blue', 'light blue'))(100)
# $ to link every single band to the image
plot(p224r63_2011$B1_sre, col=clb)

# B2: green
# Excercise do the same for the green band B2_sre
clg <- colorRampPalette(c('dark green','green','light green'))(100) 
plot(p224r63_2011$B2_sre, col=clg)

# B3 red
clr <- colorRampPalette(c('dark red','red','pink'))(100)
plot(p224r63_2011$B3_sre, col=clr)

# B4 NIR
cln <- colorRampPalette(c('red','orange','yellow'))(100)
plot(p224r63_2011$B4_sre, col=cln)

# let's change the par
par(mfrow=c(4,1)) # to have them all in a column
# recall all the bands

# close all the things before
dev.off()

## RGB
# we are goin to mount the bands 
# plotRGB, with linear stretching (to make a continuous between the colours) and associating the bands with the respective colors
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") # how we would see it with our eyes

# now we are making all the components shift and add first the NIR, removing the blue 
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") # like this we mounted the NIR on top of the red component of the RGB spectrum so all the areas reflecting in the NIR will apear red (mainly vegetation)

# put the NIR on top of the green component of the RGB
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")

# now NIR in the blue component
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

######### Second lesson

setwd("C:/lab/")
load("RS.RData")
ls() #ls() is the list function to see which packages we have already
library(raster)
p224r63_1988 <- brick("p224r63_1988_masked.grd")
plot(p224r63_1988)

#Bands of Landsat
#B1: blue
#B2: green
#B3: red
#B4: NIR

# Excercise: plot in visible RGB 321 both images
par(mfrow=c(2,1)) # you are saying that tou want the two follows images toghether in one column and two rows
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
# we can see the two images together so we can appreciate the changes, however the vegatation is difficult to see
# show the same plot but with 432 RGBspace, to see the NIR

# Excercise: plot in false colour RGB 432 both images
par(mfrow=c(2,1)) 
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

# enhance the noise, stretching more the colours
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")

# plot RGB
#bands of Landsat
#B1: blue
#B2: green
#B3: red
#B4: NIR

# we are going to use the vegetation index
dvi2011 <- p224r63_2011$B4_sre - p224r63_2011$B3_sre
cl <- colorRampPalette(c('darkorchid3','light blue','lightpink4'))(100) 
plot(dvi2011,col=cl)

# Excercise: dvi for 1988
dvi1988 <- p224r63_1988$B4_sre - p224r63_1988$B3_sre
cl <- colorRampPalette(c('darkorchid3','light blue','lightpink4'))(100) 
plot(dvi2011,col=cl)

# dff from one year to the other
diff <- dvi2011 - dvi1988
plot(diff)

# let's see the effect of changing the grain (dimension of the pixels) 
# aggregate function: aggregates pixels to make a coarser grain, "fact" is the argument that indicates the factor of increase of the pixels.
# this process is called resampling 
p224r63_2011res <- aggregate(p224r63_2011, fact=10)
p224r63_2011res100 <- aggregate(p224r63_2011, fact=100)

par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res100, r=4, g=3, b=2, stretch="Lin")

####### 6. R_code_point_pattern_analysis #######
################################################

# Point pattern analysis: density map

install.packages("spatstat") # spatstat is a package for the statistical analysis of spatial point patterns
library(spatstat)

attach(covid)
head(covid)
# let's give a name to what we are about to make -> covids. ppp is planar point pattern 
# then explain x and y variables and the range for the numbers with c
covids <- ppp(lon, lat, c(-180,180), c(-90,90)) # ?ppp creates an object of class "ppp" representing a point pattern dataset in the two-dimensional plane
# density of the covids object that we created before
d <- density(covids)
# to show the map i use plot
plot(d)
# let's put the points inside this plot
points(covids)

### Second lesson
setwd("C:/lab/")
load("pointpattern.RData") # I load the work previously done and saved
library("spatstat")

# density map
plot(d)
points(covids)
# download coastlines .zip file from IOL and copy all the files into lab folder
# rgdal package provides bindings to the 'Geospatial' Data Abstraction Library 
install.packages("rgdal")
library(rgdal)

# let's input vector line (x0y0, x1y1, x2y2..)
# #read0GR within rgdal is a function that reads an OGR data source and layer into a suitable Spatial vector object
coastlines <- readOGR("ne_10m_coastline.shp")

#add--> add to the previous plot,  it doesn't erease the previous data 
plot(coastlines, add=T)

# cl <- colorRamPalette(c('yellow', 'orange', 'red'))(100), we want red the most dense part and yellow the low dense part, 100=concern all possible color from yellow to red
cl <- colorRampPalette(c('yellow', 'orange', 'red')) (100)
plot(d, col=cl)
points(covids)
plot(coastlines, add=T)

# Exercise: new colour ramp palette
cl <- colorRampPalette(c("lightblue", "blue", "yellow", "orange", "red")) (100)
plot(d, col=cl, main="Covid19 Density")
points(covids)
plot(coastlines, add=T)

# In order to export the map begin with pdf(), after put all the commands for the map and finish with dev.off
pdf("covid_density.pdf")
cl <- colorRampPalette(c("lightblue", "blue", "yellow", "orange", "red")) (100)
plot(d, col=cl, main="Covid19 Density")
points(covids)
plot(coastlines, add=T)
dev.off()

####### 7. R_code_ecosystem_functioning #######
###############################################








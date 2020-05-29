# R_code_snow.r

setwd("C:/lab/") # windows

# install.packages("ncdf4")
library(ncdf4) # in order to read netCDF files, all copernicus data use this extension
library(raster)

snowmay <- raster("c_gls_SCE_202005260000_NHEMI_VIIRS_V1.0.1.nc")
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 

# Exercise: plot snow cover with the cl palette
plot(snowmay,col=cl)

##### import snow data

setwd("C:/lab/snow/")

snow2000r <- raster("snow2000r.tif")
snow2005r <- raster("snow2005r.tif")
snow2010r <- raster("snow2010r.tif")
snow2015r <- raster("snow2015r.tif")
snow2020r <- raster("snow2020r.tif")

par(mfrow=c(2,3))
plot(snow2000r, col=cl)
plot(snow2005r, col=cl)
plot(snow2010r, col=cl)
plot(snow2015r, col=cl)
plot(snow2020r, col=cl)

########## we can do the same we've done before with less command
## fast version of import and plot many data for lazy people
# is used to apply a function, in this case "raster" to several layer in one time 

# list.files function is used to do the list of all the files in a cerain place considering a repeting pattern in the name of the files
rlist <- list.files(pattern="snow")

# we use the function lapply to apply the raster function to all the list we've done before
import <- lapply(rlist, raster)

# when i have so many raster files is better to put them in a stack
snow.multitemp <- stack(import)  
plot(snow.multitemp, col=cl)

# I can also chose which ones to plot
par(mfrow=c(1,2))
plot(snow.multitemp$snow2000r, col=cl)
plot(snow.multitemp$snow2020r, col=cl)

par(mfrow=c(1,2))
plot(snow.multitemp$snow2000r, col=cl, zlim=c(0,250))
plot(snow.multitemp$snow2020r, col=cl, zlim=c(0,250))


#### Let's make a prediction

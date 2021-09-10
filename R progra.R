####### INDICE DE ARIDEZ MARTONNE 2014 #########
getwd()
library(raster)
library(tmap)
library(rcartocolor)
library(sf)
library(rgdal)
library(raster)
library(dplyr)
library(RColorBrewer)
library(tidyverse)

setwd("D:/TRABAJO FINALPROGRAMACIÓN")

#### PRECIPITACION 2016######

#### cargando rastes de precipitacion#######

grids <- list.files('D:/TRABAJO FINALPROGRAMACIÓN/datos/PRECIPITACION 2016', full.names = TRUE, pattern = "*.tif")

######RASTER STACK ######

prp_stack <- stack(grids)

####Suma precipitacion anual #####

prp_anual <- sum(prp_stack)
plot (prp_anual)

######PROVINCIA ########
prov <- readOGR("D:/TRABAJO FINALPROGRAMACIÓN/MATERIALES/PROVINCIAS.shp")
plot(prov)

pisco <- prov[prov$PROVINCIA == "PISCO",]
plot(pisco)

######### cortamos pisco #########
prp_anual_pisco <- crop(prp_anual,pisco)
plot(prp_anual_pisco)
plot(pisco, add = TRUE)

#####Guardamos raster ##################
writeRaster(prp_anual_pisco,filename = "Precipitacion anual pisco 2016",format = "GTiff",overwrite = TRUE)

####################### T min anual #####################
tmn <- list.files('D:/TRABAJO FINALPROGRAMACIÓN/datos/T° MINIMA 2016/2016', full.names = TRUE, pattern = "*.tif")
tmin_stack <- stack(tmn)
tmin_anual <- sum(tmin_stack)
tmin_anual_prom <- tmin_anual/12
tmin_prom_anual_pisco <- crop(tmin_anual_prom,pisco)
plot(tmin_prom_anual_pisco)
plot(pisco, add = TRUE)
writeRaster(tmin_prom_anual_pisco,filename = "Temperatura promedio minima 2016",format = "GTiff",overwrite = TRUE )

##################### T max anual ######################
tmax <- list.files('D:/TRABAJO FINALPROGRAMACIÓN/datos/T° MAXIMA 2016/2016', full.names = TRUE, pattern = "*.tif")
tmax_stack <- stack(tmax)
tmax_anual <- sum(tmax_stack)
tmax_anual_prom <- tmax_anual /12
tmax_prom_anual_pisco <- crop(tmax_anual_prom ,pisco)
plot(tmax_prom_anual_pisco)
plot(pisco, add = TRUE)
writeRaster(tmax_prom_anual_pisco,filename = "Temperatura promedio maxima 2016",format = "GTiff",overwrite = TRUE )

########## T media ##############
tmd <- (tmin_prom_anual_pisco + tmax_prom_anual_pisco )/2
writeRaster(tmd,filename = "Temperatura promedio anual 2016",format = "GTiff",overwrite = TRUE )

### DANTIN REVENGA###
 
danreven <- (tmd/prp_anual_pisco)*100
plot(danreven)
plot(pisco, add = TRUE)

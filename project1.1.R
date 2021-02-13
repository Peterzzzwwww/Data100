
rm(list=ls(all=TRUE))


#install.packages("tidyverse", dependencies = TRUE)
#install.packages("sf", dependencies = TRUE)

library(tidyverse)
library(sf)
setwd("~/Desktop/R&Rstudio scripts/data/project one")

lbr_int  <- read_sf("gadm36_GHA_shp/gadm36_GHA_0.shp")

View(lbr_int)
class(lbr_int)
st_geometry(lbr_int)

ggplot() +
  geom_sf(data = lbr_int,
          size = 1.5,
          color = "gold",
          fill = "green",
          alpha = 0.5) +
  geom_sf_text(data = lbr_int,
               aes(label = "Ghana"),
               size = 1.5,
               color = "green")
lbr_adm1  <- read_sf("gadm36_GHA_shp/gadm36_GHA_1.shp")
View(lbr_adm1)
#class(lbr_adm1)
st_geometry(lbr_adm1)

ggplot() +
  geom_sf(data = lbr_adm1,
          size = 0.65,
          color = "gray50",
          fill = "gold3",
          alpha = 0.65) +
  geom_sf(data = lbr_int,
          size = 2,
          color = "black",
          alpha = 0) +
  geom_sf_text(data = lbr_adm1,
               aes(label = NAME_1),
               size = 2,
               ) 
  



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

# Challlange Question

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

# Individual Strech Goal2

lbr_adm2 <- read_sf("gadm36_GHA_shp/gadm36_GHA_2.shp")
st_geometry(lbr_adm2)
new_sf_obj <- lbr_adm1 %>%
  filter(NAME_1 == "Ashanti")

old_sf_obj <- lbr_adm2 %>%
  filter(NAME_1 == "Ashanti") 
  ggplot() +
  geom_sf(
    size = 2) +
  geom_sf_text(data = new_sf_obj,
    aes(label = NAME_1),
               size = 1) +
  geom_sf(data = old_sf_obj,
          size = 2,
          alpha = 1) +
  geom_sf_text(data = old_sf_obj,
               aes(label = NAME_2),
               size = 2) +
  xlab("longitude") + ylab("latitude") +
  ggtitle("Ashanti", subtitle = "A county in south Ghana") +
  theme(plot.title = element_text(hjust = 0.5), 
        plot.subtitle = element_text(hjust = 0.5))

ggsave("montserrado.png")



install.packages("devtools")
library(devtools)
devtools::install_github("yutannihilation/ggsflabel")
library(ggsflabel)
### Create Larger Map of Liberia with Rectangles identifying area of Detailed Maps

# Individual Strech Goal3

plot1 <- ggplot() +
  geom_sf(data = lbr_adm1,
          size = 0.5,
          color = "gray50",
          fill = "gold3",
          alpha = 0.5) +
  geom_sf(data = lbr_int,
          size = 2.0,
          alpha = 0) +
  geom_rect(data = lbr_adm1, xmin = -10.95, xmax = -10.3, ymin = 6.2, ymax = 6.9, 
            fill = NA, colour = "green", size = 2) +
  geom_rect(data = lbr_adm1, xmin = -8.80, xmax = -7.35, ymin = 4.3, ymax = 5.65, 
            fill = NA, colour = "blue", size = 2) +
  geom_sf_text(data = lbr_adm1,
               aes(label = NAME_1),
               size = 3) +
  geom_sf_text(data = mont_cnty,
               aes(x = -10.60, y = 6.05, label = "Detail A"),
               size = 5,
               color = "green") +
  geom_sf_text(data = east_cnties,
               aes(x = -9.10, y = 4.6, label = "Detail B"),
               size = 5,
               color = "blue") +
  xlab("longitude") + ylab("latitude") +
  ggtitle("Ghana", subtitle = "Details A & B") +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5),
        panel.background = element_rect(fill = "azure"),
        panel.border = element_rect(fill = NA))

### Create Detail A Map

mont_cnty <- lbr_adm1 %>%
  filter(NAME_1 == "Ashanti")

plot2 <- lbr_adm2 %>%
  filter(NAME_1 == "Ashanti") %>%
  ggplot() +
  geom_sf(size = .15) +
  geom_sf_text(aes(label = NAME_2),
               size = 1.75) +
  geom_sf(data = mont_cnty,
          size = .5,
          alpha = 0) +
  geom_sf_text(data = mont_cnty,
               aes(label = NAME_1),
               size = 3.75,
               alpha = .5) +
  xlab("longitude") + ylab("latitude") +
  ggtitle("Detail A", subtitle = "Ashanti County") +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5),
        panel.background = element_rect(fill = "azure"),
        panel.border = element_rect(fill = NA))


### Create Detail B Map

east_cnties <- lbr_adm1 %>%
  filter(NAME_1 == "Brong Ahafo")

plot3 <- lbr_adm2 %>%
  filter(NAME_1 == "Brong Ahafo") %>%
  ggplot() +
  geom_sf(size = .15) +
  
  geom_sf_text(aes(label = NAME_2),
               size = 1.75) +
  geom_sf(data = east_cnties,
          size = .5,
          alpha = 0) +
  geom_sf_text(data = east_cnties,
               aes(label = NAME_1),
               size = 3.75,
               alpha = .5) +
  xlab("longitude") + ylab("latitude") +
  ggtitle("Detail B", subtitle = "Brong Ahafo") +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5),
        panel.background = element_rect(fill = "azure"),
        panel.border = element_rect(fill = NA))



ggplot() +
  coord_equal(xlim = c(0, 6.0), ylim = c(0, 4), expand = FALSE) +
  annotation_custom(ggplotGrob(plot1), xmin = 0.0, xmax = 4.0, ymin = 0, 
                    ymax = 4.0) +
  annotation_custom(ggplotGrob(plot3), xmin = 4.0, xmax = 6.0, ymin = 0, 
                    ymax = 2.0) +
  annotation_custom(ggplotGrob(plot2), xmin = 4.0, xmax = 6.0, ymin = 2.0, 
                    ymax = 4.0) +
  theme_void()

ggsave("details.png")


# File: csv2spdf.r
# Author: Marcello Barisonzi
# Purpose: import CSV with Traffic Flow data and convert to SpatialPointsDataFrame

library(sp)
library(dplyr)

csv2spdf <- function(csv_file_path, city_name) {

    # read CSV file, select city
    csv_raw <- filter(read.csv(csv_file_path), traffic_city==city_name)

    # Transform coordinates from string to data pair
    coords <- cbind( as.numeric(gsub(".*?([-]*[0-9]+[.][0-9]+).*", "\\1", csv_raw$WKT)),
                     as.numeric(gsub(".* ([-]*[0-9]+[.][0-9]+).*", "\\1", csv_raw$WKT)))
    csv_raw$WKT <- NULL

    # Create SpatialPointsDataFrame from coordinates and data
    sp_dat = SpatialPointsDataFrame( coords=coords, 
                                     proj4string=CRS("+proj=longlat +datum=WGS84"), 
                                     data=as.data.frame(csv_raw) )

    return(sp_dat)
}
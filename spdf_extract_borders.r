# File: spdf_extract_borders.r
# Author: Marcello Barisonzi
# Purpose: Extract poly borders from SpatialPointsDataFrame

extractCoords <- function(sp.df, largest.only=FALSE)
{

    n_pols <- length(sp.df@polygons[[1]]@Polygons)

    results <- list()

    if (largest.only) {
        max_i <- 0
        max_a <- 0
        for(i in 1:n_pols)
        {
            this.area <- sp.df@polygons[[1]]@Polygons[[i]]@area
            if( this.area > max_a ) {
                max_a <- this.area
                max_i <- i
            }
        }   
        results[[1]] <- sp.df@polygons[[1]]@Polygons[[max_i]]@coords   
    }
    else {
        for(i in 1:n_pols)
        {
            results[[i]] <- sp.df@polygons[[1]]@Polygons[[i]]@coords
        }
    }
    results <- Reduce(rbind, results)
    return(results)
}

spdf_extract_borders <- function(csd_layer, city_name, largest.only=FALSE) {

    sub_layer <- subset(csd_layer, CSDNAME==city_name)

    return(extractCoords(sub_layer, largest.only=largest.only))
}

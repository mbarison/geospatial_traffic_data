# File: spdf_extract_borders.r
# Author: Marcello Barisonzi
# Purpose: Extract poly borders from SpatialPointsDataFrame

extractCoords <- function(sp.df)
{
    results <- list()
    for(i in 1:length(sp.df@polygons[[1]]@Polygons))
    {
        results[[i]] <- sp.df@polygons[[1]]@Polygons[[i]]@coords
    }
    results <- Reduce(rbind, results)
    return(results)
}

spdf_extract_borders <- function(csd_layer, city_name) {

    sub_layer <- subset(csd_layer, CSDNAME==city_name)

    return(extractCoords(sub_layer))
}

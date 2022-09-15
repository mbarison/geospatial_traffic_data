library(dplyr)
library(geoR)

spdf2geodata <- function(df, borders=NULL) {

    # Get list of column names
    col_names <- names(df)[grepl("x20[0-9]{2}", names(df))]

    gd <- as.geodata(df, data.col=col_names) # na.action="none")

    if (!is.null(borders)) {
        gd$borders = borders
    }

    return(gd)
}
source("./scripts/utils.R")

#Setup environment
sub_folders <- list.files()
raw_location <- grep("raw", sub_folders, value=T)
path_to_raw <- (paste0(getwd(), "/", raw_location))
raw_data <- dir(path_to_raw, recursive=T, pattern = "S2301_with_ann", full.names = TRUE)  # employment data for 5Y 2015, and 5Y 2016

# Retrieve census tracts
city.tracts <- getHartfordTracts(path_to_raw);

# extract information and write to CSV file
employment2015 <- retrieveEmploymentDataWithMoE(raw_data[1], city.tracts)
WriteDFToTable(employment2015, "employment-data-2015-with-moe.csv")

employment2016 <- retrieveEmploymentDataWithMoE(raw_data[2], city.tracts)
WriteDFToTable(employment2016, "employment-data-2016-with-moe.csv")

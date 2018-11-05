ToNumeric <- function (factor) {
  return(as.numeric(as.character(factor)))
}

ExtractNumData <- function (factor) {
  return(ToNumeric(factor[1:length(factor)]))
}

WriteDFToTable <- function(df, filename){
  write.table(
    df,
    file = file.path(getwd(), "data", filename),
    sep = ",",
    row.names = FALSE
  )
}

# This function expects a file called ACS-hartford-tracts.csv, which contains FIPS data for tracts in hartford county
getHartfordTracts <- function (path_to_raw){
  tracts <- read.csv(dir(path_to_raw, pattern = "hartford-tracts", full.names = TRUE))
  return(tracts$FIPS)
}

## Note: This function uses hardcoded column references because census "tidy column names" provided by FactFinder were inaccurate, duplicate, or badly named.
retrieveEmploymentDataWithMoE <- function(filepath, tracts){
  employement.data <- read.csv(filepath)
  employement.data <- employement.data[as.numeric(as.character(employement.data$GEO.id2)) %in% tracts,]

  total.pop <- employement.data$HC01_EST_VC01
  total.pop.moe <- employement.data$HC01_MOE_VC01

  labour.force.rate <- employement.data$HC02_EST_VC01
  labour.force.rate.moe <- employement.data$HC02_MOE_VC01

  labour.force <- ExtractNumData(labour.force.rate) * ExtractNumData(total.pop) / 100
  labour.force.moe <- ExtractNumData(labour.force.rate.moe) * ExtractNumData(total.pop.moe) /100

  unemp.rate <- employement.data$HC04_EST_VC01
  unemp.rate.moe <- employement.data$HC04_MOE_VC01

  sanitised_employment <- data.frame(tracts,
                                     total.pop, total.pop.moe,
                                     labour.force.rate, labour.force.rate.moe,
                                     labour.force, labour.force.moe,
                                     unemp.rate, unemp.rate.moe
  )
  colnames(sanitised_employment) <- c("ID",
                                      "Total population over 16 years old", "Total Population Margin of Error",
                                      "Labor Force Participation Rate", "Labor Force Participation Rate MoE",
                                      "Labor Force Total Participation", "Labor Force Total Participation MoE",
                                      "Unemployment Rate", "Unemployment Rate MoE"
  )
  return(sanitised_employment)
}

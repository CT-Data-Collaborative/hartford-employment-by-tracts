# read csv data from acquired data source

ToNumeric <- function (factor) {
 return(as.numeric(as.character(factor)))
}

ExtractNumData <- function (factor) {
 return(ToNumeric(factor[2:length(factor)]))
}

WriteDFToTable <- function(df, filename){
  write.table(
    df,
    file = file.path(getwd(), "data", filename),
    sep = ",",
    row.names = FALSE
  )
}

data <- read.csv(
              list.files("raw", pattern = "*.csv", full.names = TRUE)[1]
            )

fips <- ExtractNumData(data$FIPS)

# create data frame for total population (denominator) and write to file
population.total <- ExtractNumData(data$Total.Population)
denomenator.df <- data.frame(fips, population.total)
colnames(denomenator.df) <- c("FIPS Code", "Total Population 2011-2015")
WriteDFToTable(denomenator.df, "population-denominator.csv")

# create dataframe for young population (<18 years of age) and write to file
population.young <- ExtractNumData(data$Total.Population..Under.5.Years) +
                    ExtractNumData(data$Total.Population..5.to.9.Years) +
                    ExtractNumData(data$Total.Population..10.to.14.Years) +
                    ExtractNumData(data$Total.Population..15.to.17.Years)
population.young.df <- data.frame(fips, population.young)
colnames(population.young.df) <- c("FIPS Code", "Population under 18 years old 2011-2015")
WriteDFToTable(population.young.df, "population-young.csv")

# create dataframe for elderly population (>=65 years of age) and write to file
population.elderly <- ExtractNumData(data$Total.Population..65.to.74.Years) +
                      ExtractNumData(data$Total.Population..75.to.84.Years) +
                      ExtractNumData(data$Total.Population..85.Years.and.Over)
population.elderly.df <- data.frame(fips, population.elderly)
colnames(population.elderly.df) <- c("FIPS Code", "Population above 65 years old 2011-2015")
WriteDFToTable(population.elderly.df, "population-elderly.csv")

# create dataframe for prime working population (>=25, <55 years of age) and write to file
population.prime.working <- ExtractNumData(data$Total.Population..25.to.34.Years) +
                            ExtractNumData(data$Total.Population..35.to.44.Years) +
                            ExtractNumData(data$Total.Population..45.to.54.Years)
population.working.df <- data.frame(fips, population.prime.working)
colnames(population.working.df) <- c("FIPS Code", "Population between 25 to 54 years old 2011-2015")
WriteDFToTable(population.working.df, "population-prime-working.csv")

# create dataframe for median age and write to file
population.median.age <- ExtractNumData(data$Median.Age.)
population.median.df <- data.frame(fips, population.prime.working)
colnames(population.median.df) <- c("FIPS Code", "Population median age 2011-2015")
WriteDFToTable(population.median.df, "population-median.csv")


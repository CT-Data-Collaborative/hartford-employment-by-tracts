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

# Total Labour Force (LF) stats
White.LF <- ExtractNumData(data$White.16.Years.Old.in.Civilian.Labor.Force.)
BoAA.LF <- ExtractNumData(data$Black.or.African.American.16.Years.Old.in..Civilian.Labor.Force.)
AIAN.LF <- ExtractNumData(data$American.Indian.and.Alaska.Native.16.Years.Old.in..Civilian.Labor.Force.)
Asian.LF <- ExtractNumData(data$Asian.16.Years.Old.in.Civilian.Labor.Force.)
NHawaiian.LF <- ExtractNumData(data$Native.Hawaiian.and.Other.Pacific.Islander.16..Years.Old.in.Civilian.Labor.Force.)
SomeR.LF <- ExtractNumData(data$Some.Other.Race.16.Years.Old.in.Civilian.Labor.Force.)
ToMR.LF <- ExtractNumData(data$Two.or.More.Races.16.Years.Old.in.Civilian.Labor.Force.)
#=======
total.LF <- White.LF + BoAA.LF + AIAN.LF + Asian.LF + NHawaiian.LF + SomeR.LF + ToMR.LF
total.LF.df <- data.frame(fips, total.LF)
colnames(total.LF.df) <- c("Id", "y_2011-2015")
WriteDFToTable(total.LF.df, "total-labour-force.csv")

# Employment Stats
White.Employed <- ExtractNumData(data$White.16.Years.Old.in.Civilian.Labor.Force..Employed)
BoAA.Employed <- ExtractNumData(data$Black.or.African.American.16.Years.Old.in..Civilian.Labor.Force..Employed)
AIAN.Employed <- ExtractNumData(data$American.Indian.and.Alaska.Native.16.Years.Old.in..Civilian.Labor.Force..Employed)
Asian.Employed <- ExtractNumData(data$Asian.16.Years.Old.in.Civilian.Labor.Force..Employed)
NHawaiian.Employed <- ExtractNumData(data$Native.Hawaiian.and.Other.Pacific.Islander.16..Years.Old.In.nbsp..Civilian.Labor.Force..Employed)
SomeR.Employed <- ExtractNumData(data$Some.Other.Race.16.Years.Old.in.Civilian.Labor.Force..Employed)
ToMR.Employed <- ExtractNumData(data$Two.or.More.Races.16.Years.Old.in.Civilian.Labor.Force..Employed)
#=======
total.Employed <- White.Employed + BoAA.Employed + AIAN.Employed + Asian.Employed + NHawaiian.Employed + SomeR.Employed + ToMR.Employed
total.Employed.df <- data.frame(fips, total.Employed)
colnames(total.Employed.df) <- c("Id", "y_2011-2015")
WriteDFToTable(total.LF.df, "employed-labour-force.csv")


# CSV to allow double checking work
check.df <- data.frame(fips,
                       White.LF, White.Employed,
                       BoAA.LF, BoAA.Employed,
                       AIAN.LF, AIAN.Employed,
                       Asian.LF, Asian.Employed,
                       NHawaiian.LF, NHawaiian.Employed,
                       SomeR.LF, SomeR.Employed,
                       ToMR.LF, ToMR.Employed
                       )
colnames(check.df) <- c("ID",
                        "Total White Labour Force", "Total White Employed",
                        "Total Black or African American Labour Force", "Total Black or African American Employed",
                        "Total American Indian and Alaska Native Labour Force", "Total American Indian and Alaska Native Employed",
                        "Total Asian Labour Force", "Total Asian Employed",
                        "Total Native Hawaiian Labour Force", "Total Native Hawaiian Employed",
                        "Total Some Race Labour Force", "Total Some Race Employed",
                        "Total Two or More Race Labour Force", "Total Two or More Race Employed"
                        )
WriteDFToTable(check.df, "check-work.csv")


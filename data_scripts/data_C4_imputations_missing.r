
library(dplyr)
library(sqldf)

type <- "v1"

year_0 <- 2023

options("scipen" = 1000)

canum <- readRDS(paste("data/","C1_her2024_canum_without_imputations_", year_0, ".rds", sep=""))

names(canum)

canum1<-canum[, c("ctry","year","area","fleet","subFleet","quarter","sppName","wr","canum_1000","weca_g","leca_cm","catch_t","noSample","noLength","noAge")]

#Check if figures are unique


test <-
  distinct(
    canum1,
    ctry,
    year,
    area,
    fleet,
    subFleet,
    quarter,
    sppName,
    wr,
    noSample,
    noLength,
    noAge
  )

test_1 <-
  distinct(
    canum1,
    ctry,
    year,
    area,
    fleet,
    subFleet
  )

length(unique(canum1$ctry))
length(unique(canum1$ctry))*10*4*9



##Overview of sampling and strat with missing 


canum1$canum_1000 <-
  ifelse(is.na(canum1$canum_1000), 0, canum1$canum_1000)

canumSum <-
  aggregate(
    canum_1000 ~ ctry + year + area + subFleet + quarter + sppName + catch_t +
      noSample + noLength + noAge,
    data = canum1,
    FUN = sum
  )
canumSum <- rename(canumSum, canumTotal = canum_1000)

canumSum$comment <-
  ifelse(
    canumSum$canumTotal > 0 &
      canumSum$noSample == 0,
    "National imputation",
    ifelse(
      canumSum$catch_t == 0,
      "No landings",
      ifelse(canumSum$noSample > 0, "Sampling", "")
    )
  )

canumSum$useYear <-
  ifelse(canumSum$noSample > 0 |
           canumSum$comment == "National imputation",
         canumSum$ctry,
         "")

canumSum$useCtry <-
  ifelse(canumSum$noSample > 0 |
           canumSum$comment == "National imputation",
         canumSum$year,
         "")
canumSum$useArea <-
  ifelse(canumSum$noSample > 0 |
           canumSum$comment == "National imputation",
         canumSum$area,
         "")
canumSum$useSubFleet <-
  ifelse(canumSum$noSample > 0 |
           canumSum$comment == "National imputation",
         canumSum$subFleet,
         "")
canumSum$useQuarter <-
  ifelse(canumSum$noSample > 0 |
           canumSum$comment == "National imputation",
         canumSum$quarter,
         "")

write.table(
  canumSum,
  paste("data/", "C4_her2024_missing_bio_", year_0, ".csv", sep = ""),
  sep = ",",
  row.names = F
)
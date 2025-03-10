

library(dplyr)
library(sqldf)

year_0 <- 2024

filled <-
  read.table(
    paste(
      "boot/data/imputations/",
      "C4_her2024_missing_bio_",
      year_0,
      "_filled.csv",
      sep = ""
    ),
    sep = ";",
    header = T
  )

filled$comment1 <-
  paste(
    filled$useYear,
    " ",
    filled$useCtry,
    " Q",
    filled$useQuarter,
    " ",
    filled$useArea,
    " fleet - ",
    filled$useSubFleet,
    sep = ""
  )
filled$comment1 <-
  ifelse(
    filled$comment == "No landings",
    "No landings",
    ifelse(
      filled$comment == "National imputation",
      "National imputation",
      filled$comment1
    )
  )



canum <-
  readRDS(paste(
    "data/",
    "C1_her2024_canum_without_imputations_",
    year_0,
    ".rds",
    sep = ""
  ))
canum_year_before <- readRDS(paste(
  "boot/data/data_from_past_years/",
  "C1_her2024_canum_without_imputations_", year_0-1, ".rds",
  sep = ""
))

canum <- bind_rows(canum, canum_year_before)

names(canum)
canum1 <-
  canum[, c(
    "ctry",
    "year",
    "area",
    "fleet",
    "subFleet",
    "quarter",
    "sppName",
    "wr",
    "canum_1000",
    "weca_g",
    "leca_cm",
    "catch_t",
    "noSample",
    "noLength",
    "noAge"
  )]
canum1$canum_1000 <-
  ifelse(is.na(canum1$canum_1000), 0, canum1$canum_1000)

wr <- distinct(canum, wr)
filled1 <- sqldf("select * from filled, wr")

canum1 <- rename(canum1, catch_t_canum = catch_t)

filled2 <-
  merge(
    filled1,
    canum1,
    by.x = c(
      "useYear",
      "useCtry",
      "useArea",
      "useSubFleet",
      "useQuarter",
      "wr"
    ),
    by.y = c("year", "ctry", "area", "subFleet", "quarter", "wr"),
    all.x = T
  )

#clean up variables

filled3 <-
  filled2[, c(
    "ctry",
    "year",
    "area",
    "fleet",
    "subFleet",
    "quarter",
    "sppName.x",
    "catch_t",
    "noSample.x",
    "noLength.x",
    "noAge.x",
    "canumTotal",
    "comment",
    "comment1",
    "wr",
    "canum_1000",
    "weca_g",
    "leca_cm",
    "catch_t_canum"
  )]

filled4 <-
  rename(
    filled3,
    sppName = sppName.x,
    noSamples = noSample.x,
    noLength = noLength.x,
    noAge = noAge.x
  )
filled4 <- arrange(filled4, year, quarter, ctry, area, fleet, wr)

filled4$canumNew_1000 <-
  (filled4$canum_1000 / filled4$catch_t_canum) * filled4$catch_t

filled4$fleet <- substr(filled4$subFleet, 1, 1)
unique(filled4$fleet)

filled4 <- subset(filled4, year == year_0)

filled4$canumSop <- filled4$canumNew_1000 * (filled4$weca_g / 1000)

sop <-
  aggregate(
    canumSop ~ ctry + sppName + area + fleet + subFleet + quarter + catch_t +
      comment,
    data = filled4,
    FUN = sum
  )

sop$diff <-
  round(((sop$catch_t - sop$canumSop) / sop$catch_t) * 100, digits = 0)

sop$catch_t <- round(sop$catch_t, digits = 0)
sop$sop <- round(sop$canumSop, digits = 0)

sop

#final<-filled1[,c("ctry","year.x","quarter","fleet","area", "sppName.x","wr","canumNew","weca_g","leca_cm","catch_t")]

#final$sop<-final$canumNew*(final$weca_g/1000)

filled4$canumNew_1000[is.na(filled4$canumNew_1000)] <- 0
filled4$canumSop[is.na(filled4$canumSop)] <- 0

finalHm <-
  aggregate(
    cbind(canumNew_1000, canumSop) ~ year + ctry + area + quarter + wr,
    data = filled4,
    FUN = sum
  )
finalHm$weca_g <- (finalHm$canumSop / finalHm$canumNew) * 1000
finalHm$weca_kg <- (finalHm$canumSop / finalHm$canumNew)
finalHm$canumNew_1000000 <- finalHm$canumNew_1000 / 1000
#testHm<-subset(finalHm, ctry %in% c("Denmark","Sweden") & area %in% c("27.3.a.20","27.3.a.21"))

testHm <-
  arrange(subset(finalHm, area %in% c("27.3.a.20", "27.3.a.21")), year, quarter, area, ctry, wr)

write.table(
  testHm,
  paste(
    "data/",
    "C5_her2024_canum_with_imputations_for_split_",
    year_0,
    ".csv",
    sep = ""
  ),
  sep = ",",
  row.names = F
)

#write.table(final,"X:/Assessement_discard_and_the_like/WG/HAWG/2017/WBSS_SC/Data/outputData/test.csv", sep=",", row.names=F)


final <-
  filled4[, c(
    "ctry",
    "year",
    "area",
    "fleet",
    "subFleet",
    "quarter",
    "wr",
    "canumNew_1000",
    "weca_g",
    "leca_cm",
    "catch_t",
    "noSamples",
    "noLength",
    "noAge",
    "comment",
    "comment1"
  )]
final <- rename(final, canum_1000 = canumNew_1000)

saveRDS(
  final,
  paste(
    "data/",
    "C5_her2024_canum_with_imputations_subfleets_",
    year_0,
    ".rds",
    sep = ""
  )
)
write.table(
  final,
  paste(
    "data/",
    "C5_her2024_canum_with_imputations_subfleets_",
    year_0,
    ".csv",
    sep = ""
  ),
  sep = ",",
  row.names = F
)


filled_uniq <-
  distinct(
    filled4,
    ctry,
    sppName,
    year,
    area,
    quarter,
    catch_t,
    fleet,
    subFleet,
    noSamples,
    noLength,
    noAge
  )

filledC <-
  aggregate(catch_t ~ ctry + sppName + year + area + quarter +
              fleet, data = filled_uniq,
            function(x)
              sum(x))

filledCA <-
  aggregate(
    cbind(noSamples, noLength, noAge) ~ ctry + sppName + year +
      area + quarter + fleet,
    data = filled_uniq,
    FUN = sum
  )

filledBio_new <-
  summarise(
    group_by(filled4, ctry, sppName, year, area, quarter, fleet, wr),
    leca_cm = sum(leca_cm * canumNew_1000, na.rm = T) /
      sum(canumNew_1000, na.rm = T),
    weca_g = sum(weca_g * canumNew_1000, na.rm = T) /
      sum(canumNew_1000, na.rm = T),
    canum_1000 = sum(canumNew_1000, na.rm = T)
  )

final <- left_join(left_join(filledC, filledCA), filledBio_new)

final1 <-
  final[, c(
    "ctry",
    "year",
    "area",
    "fleet",
    "quarter",
    "wr",
    "canum_1000",
    "weca_g",
    "leca_cm",
    "catch_t",
    "noSamples",
    "noLength",
    "noAge"
  )]



saveRDS(
  final1,
  paste(
    "data/",
    "C5_her2024_canum_with_imputations_",
    year_0,
    ".rds",
    sep = ""
  )
)
write.table(
  final1,
  paste(
    "data/",
    "C5_her2024_canum_with_imputations_",
    year_0,
    ".csv",
    sep = ""
  ),
  sep = ",",
  row.names = F
)



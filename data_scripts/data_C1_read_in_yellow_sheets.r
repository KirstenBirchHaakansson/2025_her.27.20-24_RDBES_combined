
library(sqldf)
library(dplyr)
library(knitr)

options("scipen" = 1000, digits = 4)

type <- "v1"

year <- 2023

# File names 2024
dnkFile <- "DC_Annex_HAWG3 her.27.20-24 template_DNK_2023.xls"
gerFile <- "2024_DC_Annex_7.1.3_HAWG_Template_her.27.20-24_update.xls"
polFile <- "2024 DC HAWG her.27.20-24 PL_v2.xls"
sweFile <- "DC_Annex_HAWG3_SWE_her.27.20-24_2023_v2.xls"
norFile <- "DC_Annex_7.1.3. HAWG Template_her_20-24_NOR2023_v2.xls"

# dnkFile_2021 <- "DC_Annex_7.1.3. HAWG Template_her_20-24_DNK_HER_2021.xls"
# gerFile_2021 <- "2a_2022 DC HAWG her.27.20-24 DE AC4_GER 2021_Landings by gear.xls"
# sweFile_2021 <- "DC_Annex_7.1.3. HAWG_SWE_her.27.20-24_2021.xls"



# Read in data ----
## Canum ----

dnk <-
  read_in_canum(
    paste("boot/data/", dnkFile, sep = ""),
    sheets = c(6, 7, 8, 9, 10, 11, 12, 13, 14, 15),
    noAgeClasses = 9
  )

ger <-
  read_in_canum(
    paste("boot/data/", gerFile, sep = ""),
    sheets = c(7:16),
    noAgeClasses = 9
  )

pol <-
  read_in_canum(
    paste("boot/data/", polFile, sep = ""),
    sheets = c(8:15),
    noAgeClasses = 9
  )

swe <-
  read_in_canum(
    paste("boot/data/", sweFile, sep = ""),
    sheets = c(6:18),
    noAgeClasses = 9
  )

nor <-
  read_in_canum(
    paste("boot/data/", norFile, sep = ""),
    sheets = c(5:11),
    noAgeClasses = 9
  )

# dnk_2021 <-
#   read_in_canum(
#     paste(rawDataPath_2021, dnkFile_2021, sep = ""),
#     sheets = c(6, 7, 8, 9, 10, 11, 12, 13, 14),
#     noAgeClasses = 9
#   )
# 
# ger_2021 <-
#   read_in_canum(
#     paste(rawDataPath_2021, gerFile_2021, sep = ""),
#     sheets = c(7:17),
#     noAgeClasses = 9
#   )
# 
# swe_2021 <-
#   read_in_canum(
#     paste(rawDataPath_2021, sweFile_2021, sep = ""),
#     sheets = c(6:12),
#     noAgeClasses = 9
#   )


## Read in samples ----  

dnkS <-
  read_in_samples(
    paste("boot/data/", dnkFile, sep = ""),
    sheets = c(6, 7, 8, 9, 10, 11, 12, 13, 14, 15),
    firstLineSamples = 27
  )

gerS <-
  read_in_samples(
    paste("boot/data/", gerFile, sep = ""),
    sheets = c(7:16),
    firstLineSamples = 27
  )

polS <-
  read_in_samples(
    paste("boot/data/", polFile, sep = ""),
    sheets = c(8:15),
    firstLineSamples = 27
  )

sweS <-
  read_in_samples(
    paste("boot/data/", sweFile, sep = ""),
    sheets = c(6:18),
    firstLineSamples = 27
  )

norS <-
  read_in_samples(
    paste("boot/data/", norFile, sep = ""),
    sheets = c(5:11),
    firstLineSamples = 27
  )


## Read in catch ----

dnkC <-
  read_in_catch(paste("boot/data/", dnkFile, sep = ""),
                sheets = 3,
                noAreas = 29)

gerC <-
  read_in_catch(paste("boot/data/", gerFile, sep = ""),
                sheets = 3,
                noAreas = 29)

polC <-
  read_in_catch(paste("boot/data/", polFile, sep = ""),
                sheets = c(3),
                noAreas = 29)

sweC <-
  read_in_catch(paste("boot/data/", sweFile, sep = ""),
                sheets = c(3),
                noAreas = 29)

norC <-
  read_in_catch(paste("boot/data/", norFile, sep = ""),
                sheets = c(3),
                noAreas = 29)


## Read in length ----

# dnkL <-
#   read_in_length(
#     paste(rawDataPath, dnkFile, sep = ""),
#     sheets = c(6, 8, 10, 12, 14, 16, 18),
#     firstLineLength = 10
#   )
# 
# gerL <-
#   read_in_length(
#     paste(rawDataPath, gerFile, sep = ""),
#     sheets = c(5:6),
#     firstLineLength = 10
#   )
# 
# polL <-
#   read_in_length(
#     paste(rawDataPath, polFile, sep = ""),
#     sheets = c(5),
#     firstLineLength = 10
#   )
# 
# sweL <-
#   read_in_length(
#     paste(rawDataPath, sweFile, sep = ""),
#     sheets = c(5:9),
#     firstLineLength = 10
#   )
# 
# norL <-
#   read_in_length(
#     paste(rawDataPath, norFile, sep = ""),
#     sheets = c(5),
#     firstLineLength = 10
#   )


## Read in landings per square from area_official ----


dnkR <-
  read_in_areaOfficial(
    path = paste("boot/data/", dnkFile, sep = ""),
    sheets = c(16),
    noRectangles = 1182
  )

gerR <-
  read_in_areaOfficial(
    path = paste("boot/data/", gerFile, sep = ""),
    sheets = c(17),
    noRectangles = 1182
  )

polR <-
  read_in_areaOfficial(
    path = paste("boot/data/", polFile, sep = ""),
    sheets = c(16),
    noRectangles = 1182
  )

sweR <-
  read_in_areaOfficial(
    path = paste("boot/data/", sweFile, sep = ""),
    sheets = c(19),
    noRectangles = 1182
  )

norR <-
  read_in_areaOfficial(
    path = paste("boot/data/", norFile, sep = ""),
    sheets = c(12),
    noRectangles = 1183
  )

# Combine and recode ----
## Canum ----

# canum_2021 <- rbind(dnk_2021, ger_2021, swe_2021)
# 
# names(canum_2021)
# 
# # Remove SWE samples- agrred by Valerio
# 
# canum_2021 <- subset(canum_2021, !((ctry == "Sweden" & year == 2021 & area == "SD 20" & quarter == 4)))
# canum_2021 <- subset(canum_2021, !((ctry == "Sweden" & year == 2021 & area == "SD 21" & quarter == 4)))

canum <- rbind(dnk, ger, pol, swe, nor) #, canum_2021)

unique(canum$ctry)

canum$ctry[canum$ctry == "POLAND"] <- "Poland"

unique(canum$sppName)

distinct(canum, ctry, sppName)

canum$sppName <- ifelse(canum$sppName %in% c("Herring (Clupea harengus)", "Herring south of 62N", "Clupea harengus", "HERRING"), "Herring", canum$sppName)

unique(canum$sppName)

unique(canum$year)

unique(canum$area)

canum$area <-
  ifelse(
    canum$area %in% c("SD 20", "IIIaN", "IIIa"),
    "27.3.a.20",
    ifelse(
      canum$area %in% c("SD 21", "IIIaS"),
      "27.3.a.21",
      ifelse(
        canum$area %in% c("SD 22", "BAL22"),
        "27.3.c.22",
        ifelse(
          canum$area %in% c("SD 23", "BAL23"),
          "27.3.b.23",
          ifelse(canum$area %in% c("SD 24", "BAL24"), "27.3.d.24", canum$area)
        )
      )
    )
  )

unique(canum$area)

distinct(canum, area, ctry, fleet)

canum$subFleet <-
  ifelse(
    canum$area %in% c("27.3.a.20", "27.3.a.21") &
      canum$fleet %in% c("C", "Fleet-C", "> 32 mm", "Fleet-A"),
    "C",
    ifelse(
      canum$area %in% c("27.3.a.20", "27.3.a.21") &
        canum$fleet %in% c("C - purse seine"),
      "C - purse seine",
      ifelse(
        canum$area %in% c("27.3.a.20", "27.3.a.21") &
          canum$fleet %in% c("C - passive"),
        "C - passive",
        ifelse(
          canum$area %in% c("27.3.a.20", "27.3.a.21") &
            canum$fleet %in% c("C - Other"),
          "C - other",
          ifelse(
            canum$area %in% c("27.3.a.20", "27.3.a.21") &
              canum$fleet %in% c("C - trawl"),
            "C - trawl",
    ifelse(
      canum$area %in% c("27.3.a.20", "27.3.a.21") &
        canum$fleet %in% c("D", "Fleet-D", "< 32mm", "< 32 mm"),
      "D",
      ifelse(
        canum$area %in% c("27.3.c.22", "27.3.b.23", "27.3.d.24", "all") &
          canum$fleet %in% c("F - active", "F Trawl"),
        "F - active",
        ifelse(
          canum$area %in% c("27.3.c.22", "27.3.b.23", "27.3.d.24", "all") &
            canum$fleet %in% c("F - passive", "F- passive", "F Gillnet", "F Trapnet") ,
          "F - passive", canum$fleet
      ))
    )
  )))))

distinct(canum, ctry, fleet, subFleet, area)

canum$fleet <-
  ifelse(
    canum$area %in% c("27.3.a.20", "27.3.a.21") &
      canum$fleet %in% c("C", "Fleet-C", "> 32 mm", "Fleet-A", "C - purse seine", "C - passive", "C - trawl", "C - Other"),
    "C",
    ifelse(
      canum$area %in% c("27.3.a.20", "27.3.a.21") &
        canum$fleet %in% c("D", "Fleet-D", "< 32mm", "< 32 mm"),
      "D",
      ifelse(
        canum$area %in% c("27.3.c.22", "27.3.b.23", "27.3.d.24", "all"),
        "F",
        canum$fleet
      )
    )
  )

distinct(canum, area, fleet)

unique(canum$wr)

canum$wr <- ifelse(canum$wr %in% c("8.000000", "8"), "8+", canum$wr)

unique(canum$wr)

##Handling units

unique(canum$canum_unit)

unit <- distinct(canum, ctry, canum_unit)

#subset(canum, canum_unit=="(1000)")

canum$canum_1000 <- ifelse(canum$canum_unit == "(millions)", canum$canum*1000, canum$canum)

unique(canum$weca_unit)
weca_unit <- distinct(canum, ctry, weca_unit)
canum$weca_g <-
  ifelse(canum$weca_unit %in% c("(Kg)", "(kg)"),
         canum$weca * 1000,
         canum$weca)

unique(canum$leca_unit)
canum$leca_cm <- ifelse(canum$leca_unit != "(cm)", "", canum$leca)

unique(canum$catch_unit)
canum$catch_t <- ifelse(canum$catch_unit != "(t)", "", canum$catch)

##Add zero's to canum
canum <- subset(canum,!is.na(wr))

year_dummy <- distinct(canum, year)
ctry <- distinct(canum, ctry)
sppName <- distinct(canum, sppName)
fleet <- distinct(canum, fleet, area)
wr <- distinct(canum, wr)
quarter <- distinct(canum, quarter)

dummy <-
  sqldf("select * from year_dummy, ctry, sppName, fleet, wr, quarter")

canum0 <-
  canum[, c("year", "ctry", "sppName", "fleet", "area", "wr", "quarter")]
dummy1 <- setdiff(dummy, canum0)

canum1 <- bind_rows(canum, dummy1)

#Replace NA for certain variables

canum1$canum <- ifelse(is.na(canum1$canum), 0, canum1$canum)
canum1$canum_1000 <-
  ifelse(is.na(canum1$canum_1000), 0, canum1$canum_1000)
canum1$catch_t <- ifelse(is.na(canum1$catch_t), 0, canum1$catch_t)

## Sample ----
samp <- rbind(dnkS, gerS, polS, sweS, norS)

unique(samp$noSample)

samp$noSample <- ifelse(samp$noSample == -9, 0, samp$noSample)
samp$noLength <- ifelse(samp$noLength == -9, 0, samp$noLength)
samp$noAge <- ifelse(samp$noAge == -9, 0, samp$noAge)

unique(samp$noSample)

unique(samp$ctry)
samp$ctry[samp$ctry == "POLAND"] <- "Poland"

unique(samp$sppName)

samp$sppName <-
  ifelse(
    samp$sppName %in% c(
      "Herring (Clupea harengus)",
      "Herring south of 62N",
      "Clupea harengus",
      "HERRING"
    ),
    "Herring",
    samp$sppName
  )

unique(samp$sppName)

unique(samp$year)

unique(samp$area)

samp$area <-
  ifelse(
    samp$area %in% c("SD 20", "IIIaN", "IIIa"),
    "27.3.a.20",
    ifelse(
      samp$area %in% c("SD 21", "IIIaS"),
      "27.3.a.21",
      ifelse(
        samp$area %in% c("SD 22", "BAL22"),
        "27.3.c.22",
        ifelse(
          samp$area %in% c("SD 23", "BAL23"),
          "27.3.b.23",
          ifelse(samp$area %in% c("SD 24", "BAL24"), "27.3.d.24", samp$area)
        )
      )
    )
  )

unique(samp$area)

samp$subFleet <-
  ifelse(
    samp$area %in% c("27.3.a.20", "27.3.a.21") &
      samp$fleet %in% c("C", "Fleet-C", "> 32 mm", "Fleet-A"),
    "C",
    ifelse(
      samp$area %in% c("27.3.a.20", "27.3.a.21") &
        samp$fleet %in% c("C - purse seine"),
      "C - purse seine",
      ifelse(
        samp$area %in% c("27.3.a.20", "27.3.a.21") &
          samp$fleet %in% c("C - passive"),
        "C - passive",
        ifelse(
          samp$area %in% c("27.3.a.20", "27.3.a.21") &
            samp$fleet %in% c("C - Other"),
          "C - other",
          ifelse(
            samp$area %in% c("27.3.a.20", "27.3.a.21") &
              samp$fleet %in% c("C - trawl"),
            "C - trawl",
    ifelse(
      samp$area %in% c("27.3.a.20", "27.3.a.21") &
        samp$fleet %in% c("D", "Fleet-D", "< 32mm", "< 32 mm"),
      "D",
      ifelse(
        samp$area %in% c("27.3.c.22", "27.3.b.23", "27.3.d.24", "all") &
          samp$fleet %in% c("F - active", "F Trawl"),
        "F - active",
        ifelse(
          samp$area %in% c("27.3.c.22", "27.3.b.23", "27.3.d.24", "all") & samp$ctry != "Germany" &
            samp$fleet %in% c("F - passive", "F- passive", "F Gillnet", "F Trapnet") ,
          "F - passive", samp$fleet
      ))
    )
  )))))

distinct(canum, fleet, subFleet, area)

samp$fleet <-
  ifelse(
    samp$area %in% c("27.3.a.20", "27.3.a.21") &
      samp$fleet %in% c("C", "Fleet-C", "> 32 mm", "Fleet-A", "C - purse seine", "C - passive", "C - trawl", "C - Other"),
    "C",
    ifelse(
      samp$area %in% c("27.3.a.20", "27.3.a.21") &
        samp$fleet %in% c("D", "Fleet-D", "< 32mm", "< 32 mm"),
      "D",
      ifelse(
        samp$area %in% c("27.3.c.22", "27.3.b.23", "27.3.d.24"),
        "F",
        samp$fleet
      )
    )
  )

distinct(samp, area, fleet)

## length ----

# 
# length<-rbind(dnkL,gerL,polL,sweL,norL)
# 
# unique(length$ctry)
# 
# unique(length$sppName)
# 
# length$sppName<-ifelse(length$sppName=="Herring (Clupea harengus)", "Herring", length$sppName)
# 
# unique(length$sppName)
# 
# unique(length$year)
# 
# unique(length$area)
# 
# length$area<-ifelse(length$area %in% c("SD20","SD 20","IIIaN"), "27.3.a.20",
#                    ifelse(length$area %in% c("SD21","SD 21","IIIaS"), "27.3.a.21", 
#                    ifelse(length$area %in% c("SD22","SD 22","BAL22"), "27.3.c.22",
#                    ifelse(length$area %in% c("SD23","SD 23","BAL23"), "27.3.b.23",
#                    ifelse(length$area %in% c("SD24","SD 24","BAL24"), "27.3.d.24", length$area)))))
# unique(length$area)
# 
# distinct(length, area, fleet)
# 
# length$fleet<-ifelse(length$area %in% c("27.3.a.20","27.3.a.21") & length$fleet %in% c("C","Fleet-C","> 32 mm", "C-fleet", "Fleet C"), "C",
#                     ifelse(length$area %in% c("27.3.a.20","27.3.a.21") & length$fleet %in% c("D","Fleet-D","< 32mm","< 32 mm", "D-fleet"), "D",
#                     ifelse(length$area %in% c("27.3.c.22","27.3.b.23","27.3.d.24"),"F", length$fleet)))
# 
# distinct(length, area, fleet)
# 
# ##Handling units
# 
# length$clnum[is.na(length$clnum)]<-0
# 
# unique(length$clnum_unit)
# 
# length$clnum_1000<-ifelse(length$length_unit=="(millions)", length$clnum*1000, length$clnum)


## Catch ----

catch <- rbind(dnkC, polC, gerC, sweC, norC)

str(catch)

catch$landWt <- as.numeric(catch$landWt)
catch$unallocCatchWt <- as.numeric(catch$unallocCatchWt)
catch$misRepCatchWt <- as.numeric(catch$misRepCatchWt)
catch$disWt <- as.numeric(catch$disWt)

str(catch)

##Check codes in catch

unique(catch$ctry)
catch$ctry[catch$ctry == "POLAND"] <- "Poland"

unique(catch$area)

catch$area <- ifelse(
  catch$area == "3a/Skagerak",
  "27.3.a.20",
  ifelse(catch$area == "3a/Kategat", "27.3.a.21", catch$area)
)


catch$area <- ifelse(
  catch$area %in% c("SD 20", "IIIaN"),
  "27.3.a.20",
  ifelse(
    catch$area %in% c("SD 21", "IIIaS"),
    "27.3.a.21",
    ifelse(
      catch$area %in% c("22", "SD 22", "BAL22"),
      "27.3.c.22",
      ifelse(
        catch$area %in% c("23", "SD 23", "BAL23"),
        "27.3.b.23",
        ifelse(
          catch$area %in% c("24", "SD 24", "BAL24"),
          "27.3.d.24",
          catch$area
        )
      )
    )
  )
)
unique(catch$area)

catch[is.na(catch)] <- 0

catch$catch <-
  catch$landWt + catch$unallocCatchWt + catch$misRepCatchWt + catch$disWt


## Rect ----

rect <- rbind(dnkR, polR, gerR, sweR, norR)

str(rect)

unique(rect$ctry)
rect$ctry[rect$ctry == "POLAND"] <- "Poland"

##Check codes in rect

unique(rect$unit)

rect$catch_t <-
  ifelse(rect$unit == "(millions)", rect$landWt * 1000, rect$landWt)

# Merge samples with canum ----

canum2 <- merge(canum1, samp, all.x = T)

canum2$noSample <- ifelse(is.na(canum2$noSample), 0, canum2$noSample)
canum2$noLength <- ifelse(is.na(canum2$noLength), 0, canum2$noLength)
canum2$noAge <- ifelse(is.na(canum2$noAge), 0, canum2$noAge)

# Merge length and samples ----

# length1<-merge(length,samp, all.x=T)
# 
# length1$noSample<-ifelse(is.na(length1$noSample), 0, length1$noSample)
# length1$noLength<-ifelse(is.na(length1$noLength), 0, length1$noLength)
# length1$noAge<-ifelse(is.na(length1$noAge), 0, length1$noAge)

sw <-
  subset(canum2, ctry == "Sweden" &
           area %in% c("27.3.a.20", "27.3.a.21"))
rest <-
  subset(canum2,!(ctry == "Sweden" &
                    area %in% c("27.3.a.20", "27.3.a.21")))

# SOP correction ----



sop <-
  aggregate(((canum_1000 * weca_g) / 1000) ~ ctry + sppName + year + area +
              quarter + fleet + subFleet + catch_t,
            data = canum2,
            FUN = sum
  )

colnames(sop) <-
  c("ctry",
    "sppName",
    "year",
    "area",
    "quarter",
    "fleet",
    "subFleet",
    "catch_t",
    "sop")
sop$sop <- as.numeric(sop$sop)

canum3 <- merge(canum2, sop, all.x = T)
canum3$sopCorr <- (canum3$catch_t / canum3$sop)
canum3$canum_1000 <-
  ifelse(
    canum3$canum_1000 > 0,
    canum3$canum_1000 * (canum3$catch_t / canum3$sop),
    canum3$canum_1000
  )

testSop <-
  aggregate(((canum_1000 * weca_g) / 1000) ~ ctry + sppName + year + area +
              quarter + fleet + subFleet + catch_t,
            data = canum3,
            FUN = sum
  )


kable(arrange(distinct(canum3, ctry, year, fleet, subFleet, area, quarter, sopCorr), -sopCorr), caption = "SOP")



# Output data ----
saveRDS(canum3,
        paste(
          "data/",
          "C1_her2024_canum_without_imputations_", year, ".rds",
          sep = ""
        ))

write.table(
  canum3,
  paste(
    "data/",
    "C1_her2024_canum_without_imputations_", year, ".csv",
    sep = ""
  ),
  sep = ",",
  row.names = F,
  na = ""
)

saveRDS(sw,
        paste(
          "data/",
          "C1_SWE_her2024_fleet_C_D_before_merge_", year, ".rds",
          sep = ""
        ))

write.table(
  sw,
  paste(
    "data/",
    "C1_SWE_her2024_fleet_C_D_before_merge_", year, ".csv",
    sep = ""
  ),
  sep = ",",
  row.names = F,
  na = ""
)

saveRDS(samp, paste("data/", "C1_her2024_samples_", year, ".rds", sep = ""))
write.table(
  samp,
  paste("data/", "C1_her2024_samples_", year, ".csv", sep = ""),
  sep = ",",
  row.names = F,
  na = ""
)

saveRDS(catch, paste("data/", "C1_her2024_catch_", year, ".rds", sep = ""))
write.table(
  catch,
  paste("data/", "C1_her2024_catch_", year, ".csv", sep = ""),
  sep = ",",
  row.names = F,
  na = ""
)


saveRDS(rect, paste("data/", "C1_her2024_rect_", year, ".rds", sep = ""))
write.table(
  rect,
  paste("data/", "C1_her2024_rect_", year, ".csv", sep = ""),
  sep = ",",
  row.names = F,
  na = ""
)


# saveRDS(length1,
#         paste(dataPath, "C1_her2024_length_", year, ".rds", sep = ""))
# write.table(
#   length1,
#   paste(dataPath, "C1_her2024_length_", year, ".csv", sep = ""),
#   sep = ",",
#   row.names = F,
#   na = ""
# )




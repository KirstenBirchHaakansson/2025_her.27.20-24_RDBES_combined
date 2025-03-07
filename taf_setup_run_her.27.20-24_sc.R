
library(icesTAF)


# taf.skeleton()


draft.data(data.files = "preliminary_catch_statistics",
           data.scripts = NULL,
           originator = "ICES",
           title = "Preliminary catch statistic from ICES",
           file = T,
           append = F)

draft.data(data.files = "submitted_data/2024 DC HAWG her.27.20-24 PL.xls",
           data.scripts = NULL,
           originator = "Data submitted to HAWG",
           title = "Data from Poland",
           file = T,
           append = T)

draft.data(data.files = "submitted_data/2024 DC HAWG her.27.20-24 PL_v2.xls",
           data.scripts = NULL,
           originator = "Data corrected by Kirsten",
           title = "Data from Poland corrected by Kirsten",
           file = T,
           append = T)

draft.data(data.files = "submitted_data/2024_DC_Annex_7.1.3_HAWG_Template_her.27.20-24.xls",
           data.scripts = NULL,
           originator = "Data submitted to HAWG",
           title = "Data from Germany",
           file = T,
           append = T)

draft.data(data.files = "submitted_data/2024_DC_Annex_7.1.3_HAWG_Template_her.27.20-24_update.xls",
           data.scripts = NULL,
           originator = "Updated data submitted to HAWG",
           title = "Data from Germany, updated",
           file = T,
           append = T)

draft.data(data.files = "submitted_data/DC_Annex_7.1.1. HAWG Yellow sheet with transfer area_NOR2023.xls",
           data.scripts = NULL,
           originator = "Data submitted to HAWG",
           title = "Data from Norway",
           file = T,
           append = T)

draft.data(data.files = "submitted_data/DC_Annex_7.1.3. HAWG Template_her_20-24_NOR2023.xls",
           data.scripts = NULL,
           originator = "Data submitted to HAWG",
           title = "Data from Norway",
           file = T,
           append = T)

draft.data(data.files = "submitted_data/DC_Annex_7.1.3. HAWG Template_her_20-24_NOR2023_v2.xls",
           data.scripts = NULL,
           originator = "Data corrected by Kirsten",
           title = "Data from Norway corrected by Kirsten",
           file = T,
           append = T)

draft.data(data.files = "submitted_data/DC_Annex_HAWG3 her.27.20-24 template_DNK_2023.xls",
           data.scripts = NULL,
           originator = "Data submitted to HAWG",
           title = "Data from Denmark",
           file = T,
           append = T)

draft.data(data.files = "submitted_data/DC_Annex_HAWG3_SWE_her.27.20-24_2023.xls",
           data.scripts = NULL,
           originator = "Data submitted to HAWG",
           title = "Data from Sweden",
           file = T,
           append = T)

draft.data(data.files = "submitted_data/DC_Annex_HAWG3_SWE_her.27.20-24_2023_v2.xls",
           data.scripts = NULL,
           originator = "Data corrected by Kirsten",
           title = "Data from Sweden corrected by Kirsten",
           file = T,
           append = T)

draft.data(data.files = "data_from_past_years",
           data.scripts = NULL,
           originator = "Data from pasts years",
           title = "Paste years",
           file = T,
           append = T)

draft.data(data.files = "imputations",
           data.scripts = NULL,
           originator = "Manual imputation",
           title = "Imputations",
           file = T,
           append = T)

draft.data(data.files = "split_data",
           data.scripts = NULL,
           originator = "Results needed for the split",
           title = "Split data",
           file = T,
           append = T)

draft.data(data.files = "time_series",
           data.scripts = NULL,
           originator = "Former HAWGs",
           title = "Time series from last year",
           file = T,
           append = T)

draft.data(data.files = "data_from_tomas",
           data.scripts = NULL,
           originator = "Data from Tomas (former SC)",
           title = "Data from Tomas",
           file = T,
           append = T)

draft.data(data.files = NULL,
           data.scripts = "download_from_stockassessment_org_single_fleet.R",
           originator = "stockassessment.org",
           title = "Single fleet data from stockassessment.org",
           file = T,
           append = T)

draft.data(data.files = NULL,
           data.scripts = "download_from_stockassessment_org_multi_fleet.R",
           originator = "stockassessment.org",
           title = "Multi fleet data from stockassessment.org",
           file = T,
           append = T)

draft.data(data.files = "Herring_TAC_catches_by_area.csv",
           data.scripts = NULL,
           originator = "Updated 2024",
           title = "TAC and catch",
           file = T,
           append = T)

taf.boot()

# mkdir("data")
# mkdir("output")

# sourceTAF("data") 
# 
# sourceTAF("report") 
# run model_0....

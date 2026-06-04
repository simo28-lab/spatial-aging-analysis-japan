
# ================================
# 2. DATA LOADING & SPATIAL JOIN
# ================================

# Load dataset and shapefile
dati <- read_excel("C:/Users/Simona/Downloads/spatial/dataset spatial_final.xlsx")
giappone_shp <- st_read("C:/Users/Simona/Downloads/spatial/japan_shape/gadm41_JPN_1.shp")

# Clean prefecture names for spatial join
dati$Prefettura_Pulita <- gsub("-ken|-to|-fu|-do", "", dati$Prefetture)
dati$Prefettura_Pulita[dati$Prefettura_Pulita == "Gumma"] <- "Gunma"
dati$Prefettura_Pulita[dati$Prefettura_Pulita == "Hyogo"] <- "Hyōgo"
dati$Prefettura_Pulita[dati$Prefettura_Pulita == "Nagasaki"] <- "Naoasaki" # check spelling

# Merge spatial and tabular data
giappone_spaziale <- merge(giappone_shp, dati, by.x = "NAME_1", by.y = "Prefettura_Pulita")
data_jp <- as(giappone_spaziale, "Spatial")
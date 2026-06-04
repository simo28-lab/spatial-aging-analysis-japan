
# ================================
# 3. DATA CLEANING & FILTERING
# ================================

# Convert variables to numeric
data_jp$Densità <- as.numeric(as.character(data_jp$Densità))
data_jp$Percentuale.anziani <- as.numeric(as.character(data_jp$Percentuale.anziani))

# Remove missing / inconsistent observations
data_jp <- data_jp[!(data_jp$NAME_1 %in% c("Hokkaido", "Okinawa")), ]

# Inspect structure
str(data_jp)

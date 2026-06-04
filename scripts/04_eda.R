
# ================================
# 4. EXPLORATORY DATA ANALYSIS (EDA)
# ================================

# Relationship: Density vs Aging
windows(width = 8, height = 6)
plot(data_jp$Densità, data_jp$Percentuale.anziani,
     xlab = "Population Density (per km²)",
     ylab = "Elderly Population (%)",
     main = "Density vs Aging Relationship",
     pch = 19, col = rgb(0.2, 0.4, 0.6, 0.7),
     las = 1)

abline(lm(Percentuale.anziani ~ Densità, data = data_jp), col = "red", lwd = 2)

text(data_jp$Densità, data_jp$Percentuale.anziani,
     labels = data_jp$NAME_1, cex = 0.6, pos = 3)

grid()

# Multi-variable EDA
windows(width = 15, height = 10)
par(mfrow = c(2, 3), mar = c(4, 4, 3, 2))

plot(data_jp$Tasso.fecondità, data_jp$Percentuale.anziani,
     main="Fertility Rate", xlab="Fertility", ylab="% Elderly",
     pch=19, col="deeppink")
abline(lm(Percentuale.anziani ~ Tasso.fecondità, data=data_jp), col="red")

plot(data_jp$Numero.università, data_jp$Percentuale.anziani,
     main="Universities Density", xlab="Universities", ylab="% Elderly",
     pch=19, col="royalblue")
abline(lm(Percentuale.anziani ~ Numero.università, data=data_jp), col="red")

text(data_jp$Numero.università[data_jp$NAME_1 %in% c("Shimane", "Kyoto")],
     data_jp$Percentuale.anziani[data_jp$NAME_1 %in% c("Shimane", "Kyoto")],
     labels = c("Shimane", "Kyoto"), pos = 3)

plot(data_jp$Tasso.migratorio, data_jp$Percentuale.anziani,
     main="Migration Rate", xlab="Migration", ylab="% Elderly",
     pch=19, col="darkgreen")
abline(lm(Percentuale.anziani ~ Tasso.migratorio, data=data_jp), col="red")

plot(data_jp$Reddito, data_jp$Percentuale.anziani,
     main="Income", xlab="Income", ylab="% Elderly",
     pch=19, col="brown")
abline(lm(Percentuale.anziani ~ Reddito, data=data_jp), col="red")

plot(data_jp$Numero.ospedali, data_jp$Percentuale.anziani,
     main="Hospitals", xlab="Hospitals", ylab="% Elderly",
     pch=19, col="purple")
abline(lm(Percentuale.anziani ~ Numero.ospedali, data=data_jp), col="red")

plot(log(data_jp$Densità), data_jp$Percentuale.anziani,
     main="Log Density", xlab="Log Density", ylab="% Elderly",
     pch=19, col="orange")
abline(lm(Percentuale.anziani ~ log(Densità), data=data_jp), col="red")

par(mfrow = c(1, 1))

# ================================
# 5. SPATIAL VISUALIZATION
# ================================

coords <- coordinates(data_jp)

# Choropleth aging map
brks <- quantile(data_jp$Percentuale.anziani, probs = seq(0, 1, length.out = 7), na.rm = TRUE)
cols <- colorRampPalette(c("yellow", "red"))(6)

windows(width = 10, height = 8)
par(mar = c(1, 1, 3, 1))

plot(data_jp,
     col = cols[findInterval(data_jp$Percentuale.anziani, brks, all.inside = TRUE)],
     border = "grey80")

text(coords, labels = data_jp$NAME_1, cex = 0.5, font = 2)

title("Spatial Distribution of Aging Population")

legend("bottomleft",
       legend = paste0(round(brks[-length(brks)],1), "–", round(brks[-1],1)),
       fill = cols,
       title = "% elderly")

# Density map
brks_den <- quantile(data_jp$Densità, probs = seq(0, 1, length.out = 7), na.rm = TRUE)
cols_den <- colorRampPalette(c("#fff7bc", "#feb24c", "#e31a1c", "#800026"))(6)

windows(width = 10, height = 8)

plot(data_jp,
     col = cols_den[findInterval(data_jp$Densità, brks_den, all.inside = TRUE)],
     border = "white")

text(coords, labels = data_jp$NAME_1, cex = 0.4)

title("Population Density")

legend("bottomleft",
       legend = paste0(round(brks_den[-length(brks_den)],0), "–", round(brks_den[-1],0)),
       fill = cols_den)

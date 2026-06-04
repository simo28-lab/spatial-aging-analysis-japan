# ==============================================================================
# 09_VISUALIZATION.R 
# ==============================================================================


dir.create("outputs/figures", recursive = TRUE, showWarnings = FALSE)
dir.create("outputs/maps", recursive = TRUE, showWarnings = FALSE)
dir.create("outputs/tables", recursive = TRUE, showWarnings = FALSE)


source("C:/Users/Simona/Downloads/spatial/proj_intern/08_diagnostics.R")
coords <- coordinates(data_jp)
lag_res <- lag.listw(lw_k4, data_jp$residui_finali)

# ------------------------------------------------------------------------------
# MAPPA 1: CHOROPLETH AGING POPULATION
# ------------------------------------------------------------------------------
png("outputs/maps/01_aging_choropleth.png", width = 10, height = 8, units = "in", res = 300)
par(mar = c(2, 2, 3, 1))

plot(data_jp,
     col = cols[findInterval(data_jp$Percentuale.anziani, brks, all.inside = TRUE)],
     border = "grey40", lwd = 0.5)

text(coords, labels = data_jp$NAME_1, cex = 0.5, font = 2)
title("Spatial Distribution of Aging Population", cex.main = 1.2)

legend("bottomleft",
       legend = paste0(round(brks[-length(brks)], 1), "% – ", round(brks[-1], 1), "%"),
       fill = cols,
       title = "% Elderly",
       bty = "n", cex = 0.8)
dev.off()

# ------------------------------------------------------------------------------
# MAPPA 2: POPULATION DENSITY
# ------------------------------------------------------------------------------
png("outputs/maps/02_density_map.png", width = 10, height = 8, units = "in", res = 300)
par(mar = c(2, 2, 3, 1))

plot(data_jp,
     col = cols_den[findInterval(data_jp$Densità, brks_den, all.inside = TRUE)],
     border = "grey40", lwd = 0.5)

text(coords, labels = data_jp$NAME_1, cex = 0.5, font = 2)
title("Population Density (per km²)", cex.main = 1.2)

legend("bottomleft",
       legend = paste0(round(brks_den[-length(brks_den)], 0), " – ", round(brks_den[-1], 0)),
       fill = cols_den,
       title = "Density (km²)",
       bty = "n", cex = 0.8)
dev.off()

# ------------------------------------------------------------------------------
# MAPPA 3: LISA CLUSTER MAP
# ------------------------------------------------------------------------------
png("outputs/maps/03_lisa_map.png", width = 10, height = 8, units = "in", res = 300)
par(mar = c(2, 2, 3, 1))

plot(data_jp,
     col = cols_l[findInterval(data_jp$Ii, brks_l, all.inside = TRUE)],
     border = "grey40", lwd = 0.5)

text(coords, labels = data_jp$NAME_1, cex = 0.5, font = 2)
title("LISA Cluster Map (Local Moran's I)", cex.main = 1.2)

legend("bottomleft",
       legend = paste0("Cluster Class ", 1:6), # Nota: Per un workflow MSCI definitivo, qui dovresti mappare i quadranti statici High-High, Low-Low ecc.
       fill = cols_l,
       title = "Local Moran Index",
       bty = "n", cex = 0.8)
dev.off()

# ------------------------------------------------------------------------------
# MAPPA 4: SDM RESIDUALS
# ------------------------------------------------------------------------------
png("outputs/maps/04_sdm_residuals.png", width = 10, height = 8, units = "in", res = 300)
par(mar = c(2, 2, 3, 1))

plot(data_jp,
     col = cols_res[findInterval(data_jp$residui_finali, brks_res, all.inside = TRUE)],
     border = "grey30", lwd = 0.6)

text(coords, labels = data_jp$NAME_1, cex = 0.5, font = 2)
title("Spatial Durbin Model (SDM) Residuals", cex.main = 1.2)

legend("bottomleft",
       legend = paste0(round(brks_res[-length(brks_res)], 2), " : ", round(brks_res[-1], 2)),
       fill = cols_res,
       title = "Residuals Range",
       bty = "n", cex = 0.8)
dev.off()

# ------------------------------------------------------------------------------
# FIGURE: GRAPHICS & DIAGNOSTICS
# ------------------------------------------------------------------------------
png("outputs/figures/01_moran_scatter.png", width = 8, height = 6, units = "in", res = 300)
moran.plot(data_jp$Percentuale.anziani, lw_k4,
           labels = data_jp$NAME_1,
           main = "Moran Scatterplot (Aging Population)",
           xlab = "% Elderly (Standardized)",
           ylab = "Spatial Lag of % Elderly")
dev.off()

png("outputs/figures/02_residual_moran.png", width = 8, height = 6, units = "in", res = 300)
plot(data_jp$residui_finali, lag_res,
     pch = 19, col = "darkred",
     main = "Residual Moran Scatterplot",
     xlab = "Model Residuals",
     ylab = "Spatial Lag of Residuals")
abline(h = mean(lag_res), v = mean(data_jp$residui_finali), lty = 2, col = "grey50")
dev.off()

png("outputs/figures/03_residual_boxplot.png", width = 6, height = 6, units = "in", res = 300)
boxplot(data_jp$residui_finali,
        main = "SDM Residual Distribution",
        ylab = "Residuals", col = "lightblue")
dev.off()

# Esportazione Tabella Critica per Robustezza QA
write.csv(moran_results, "outputs/tables/moran_robustness.csv", row.names = FALSE)
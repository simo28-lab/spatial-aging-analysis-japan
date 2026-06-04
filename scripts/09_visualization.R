dir.create("outputs/figures", recursive = TRUE, showWarnings = FALSE)
dir.create("outputs/maps", recursive = TRUE, showWarnings = FALSE)
dir.create("outputs/tables", recursive = TRUE, showWarnings = FALSE)

source("C:/Users/Simona/Downloads/spatial/proj_intern/08_diagnostics.R")
png("outputs/maps/01_aging_choropleth.png", width=1200, height=900)

plot(data_jp,
     col = cols[findInterval(data_jp$Percentuale.anziani, brks, all.inside=TRUE)],
     border="grey80")

title("Aging Population Distribution")

dev.off()

png("outputs/maps/02_density_map.png", width=1200, height=900)

plot(data_jp,
     col = cols_den[findInterval(data_jp$Densità, brks_den, all.inside=TRUE)],
     border="white")

title("Population Density")

dev.off()

png("outputs/maps/03_lisa_map.png", width=1200, height=900)

plot(data_jp,
     col = cols_l[findInterval(data_jp$Ii, brks_l, all.inside=TRUE)])

title("LISA Cluster Map")

dev.off()

png("outputs/maps/04_sdm_residuals.png", width=1200, height=900)

plot(data_jp,
     col = cols_res[findInterval(data_jp$residui_finali,
                                 brks_res,
                                 all.inside=TRUE)],
     border="grey60")

title("SDM Residuals Map")

dev.off()



png("outputs/figures/01_moran_scatter.png", width=1000, height=800)

moran.plot(data_jp$Percentuale.anziani, lw_k4,
           labels=data_jp$NAME_1,
           main="Moran Scatterplot")

dev.off()


png("outputs/figures/02_residual_moran.png", width=1000, height=800)

plot(data_jp$residui_finali, lag_res,
     pch=19,
     main="Residual Moran Scatterplot")

abline(h=mean(lag_res), v=mean(data_jp$residui_finali), lty=2)

dev.off()


png("outputs/figures/03_residual_boxplot.png", width=800, height=600)

boxplot(data_jp$residui_finali,
        main="SDM Residual Distribution",
        ylab="Residuals")

dev.off()

write.csv(moran_results,
          "outputs/tables/moran_robustness.csv",
          row.names = FALSE)

# ================================
# 6. SPATIAL AUTOCORRELATION (ESDA)
# ================================

moran_results <- data.frame(
  Matrice = c("k=4","k=6","k=8","Queen","Rook","Inverse Distance"),
  Moran_I = c(
    moran.test(data_jp$Percentuale.anziani, lw_k4)$estimate[1],
    moran.test(data_jp$Percentuale.anziani, lw_k6)$estimate[1],
    moran.test(data_jp$Percentuale.anziani, lw_k8)$estimate[1],
    moran.test(data_jp$Percentuale.anziani, lw_q, zero.policy=TRUE)$estimate[1],
    moran.test(data_jp$Percentuale.anziani, lw_r, zero.policy=TRUE)$estimate[1],
    moran.test(data_jp$Percentuale.anziani, lw_inv_dist, zero.policy=TRUE)$estimate[1]
  )
)

print(moran_results)

moran_mc <- moran.mc(data_jp$Percentuale.anziani, lw_k4, nsim=9999)
geary_jp <- geary.test(data_jp$Percentuale.anziani, lw_k4)

windows()
moran.plot(data_jp$Percentuale.anziani, lw_k4, labels=data_jp$NAME_1)

lmii <- localmoran(data_jp$Percentuale.anziani, lw_k4)
data_jp$Ii <- lmii[,1]

# LISA map
brks_l <- c(-1,0,0.5,1,1.5,2,5)
cols_l <- brewer.pal(6,"Purples")

plot(data_jp,
     col = cols_l[findInterval(data_jp$Ii, brks_l, all.inside=TRUE)])
title("LISA Map")

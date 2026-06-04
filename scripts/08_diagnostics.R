
# ================================
# 10. RESIDUAL ANALYSIS
# ================================

data_jp$residui_finali <- residuals(mod_sdm)

moran.test(data_jp$residui_finali, lw_k4)

boxplot(data_jp$residui_finali)

check_residui <- data.frame(
  Prefettura = data_jp$NAME_1,
  Residuo = data_jp$residui_finali
)

check_residui <- check_residui[order(-check_residui$Residuo), ]
head(check_residui)

# Residual map
brks_res <- quantile(data_jp$residui_finali, probs=seq(0,1,length=6), na.rm=TRUE)
cols_res <- brewer.pal(5,"RdYlBu")

plot(data_jp,
     col = cols_res[findInterval(data_jp$residui_finali, brks_res, all.inside=TRUE)])

# Moran residual plot
lag_res <- lag.listw(lw_k4, data_jp$residui_finali)

plot(data_jp$residui_finali, lag_res, pch=19)
abline(h=mean(lag_res), v=mean(data_jp$residui_finali), lty=2)
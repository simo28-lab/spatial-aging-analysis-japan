
# ================================
# 7. SPATIAL MODELS
# ================================

formula_jp <- Percentuale.anziani ~ Tasso.fecondità + Reddito + Densità +
  Tasso.migratorio + Numero.università + Numero.ospedali

mod_ols <- lm(formula_jp, data = data_jp)

vif(mod_ols)

mod_manski <- sacsarlm(formula_jp, data=data_jp, listw=lw_k4, type="mixed")
mod_sdm <- lagsarlm(formula_jp, data=data_jp, listw=lw_k4, type="mixed")
mod_sar <- lagsarlm(formula_jp, data=data_jp, listw=lw_k4)
mod_sem <- errorsarlm(formula_jp, data=data_jp, listw=lw_k4)

lm.RStests(mod_ols, listw=lw_k4, test="all")

anova(mod_sdm, mod_sar)
anova(mod_sdm, mod_sem)

aic_comp <- AIC(mod_ols, mod_manski, mod_sdm, mod_sar, mod_sem)
print(aic_comp)

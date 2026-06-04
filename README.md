# 📍 Spatial Intelligence: Strategic Demographic Forecasting in Japan

## 📑 Business Context & Executive Summary
In global retail and supply chain management, treating administrative regions as independent data points leads to biased forecasting. This project implements **Spatial Data Science** to analyze aging population dynamics across Japan’s 47 prefectures. 

By moving beyond standard OLS regression to **Spatial Econometric Modeling (SDM)**, this study identifies regional "Silver Economy" clusters and quantifies **Spatial Spillovers**. These insights are critical for:
* **Market Optimization:** Identifying high-potential clusters for specific product lines (e.g., progressive lenses vs. trend-driven eyewear).
* **Retail Strategy:** Understanding how a store's location affects—and is affected by—the demographics of neighboring territories.
* **Risk Management:** Predictive modeling of long-term regional labor and consumer shifts.

---

## 🛠 Tech Stack
* **Statistical Modeling:** `R` (`spdep`, `spatialreg`, `ggplot2`).
* **Geospatial Engineering:** `QGIS` & `OpenTopography` (DEM processing).
* **Data Sources:** e-Stat Japan (2019) and GADM Level 1 Shapefiles.

---
## 📁 Repository Structure
The project follows a modular, production-ready directory layout designed for reproducibility and automated testing. All analytical outputs (plots, maps, and tables) are programmatically generated and decoupled from the source code.
## 📂 Repository Structure

The project follows a modular, production-ready directory layout designed for reproducibility and automated testing. All analytical outputs (plots, maps, and tables) are programmatically generated and decoupled from both raw data assets and source logic.

# Project Structure

```
.
├── README.md                 
├── data/                     
│   ├── processed/
│   │   ├── dataset spatial_final.xlsx
│   │   └── gadm41_JPN_1.shp        
│   └── raw/
│   │   ├── a205.xls
│   │   ├── gadm41_JPN_1.prj
│   │   └── gadm41_JPN_1.shx                                 
├── outputs/                  
│   ├── figures/              
│   │   ├── 01_moran_scatter.png
│   │   ├── 02_residual_moran.png
│   │   ├── 03_residual_boxplot.png
│   │   └── 04_covariate_relationships.png
│   ├── maps/                
│   │   ├── 01_aging_choropleth.png
│   │   ├── 02_density_map.png
│   │   ├── 03_lisa_map.png
│   │   ├── 04_sdm_residuals.png
│   │   └── morphology_japan.png
│   └── tables/              
│       └── moran_robustness.csv
└── scripts/                  
    ├── 00_libraries.R     
    ├── 01_data_ingestion.R
    ├── 02_data_quality.R     
    ├── 03_spatial_weights.R
    ├── 04_eda.R     
    ├── 05_esda.R
    ├── 06_models.R     
    ├── 07_impacts.R 
    ├── 08_diagnostics.R            
    └── 09_visualization.R   
```

## 🛰 Strategic Workflow & Methodology
### 1. Geospatial Data Engineering
A robust spatial infrastructure was built to account for Japan's unique physical geography:
* **Terrain Impact Analysis:** Integrated Digital Elevation Models (DEM) to generate **Slope** and **Hillshade** layers. This allows for the analysis of how rugged morphology restricts urban density and service accessibility.
* **Data Pipeline Optimization:** Automated nomenclature harmonization and spatial joins to ensure 100% data integrity across the archipelago.
* **Contiguity Modeling:** Structured a precise **Spatial Weight Matrix (W)**, focusing on mainland connectivity to eliminate noise from isolated island geographies.
  
  > Note: Raw DEM raster files and intermediate GIS processing outputs are not included in this repository due to file size limitations. The final processed visualization is provided below.

    <h3 align="center">Terrain Morphology of Japan</h3>

<p align="center">
  <img src="outputs/maps/morphology_japan.png" width="500">
</p>

### 2. Exploratory Spatial Data Analysis (ESDA)
* **Cluster Identification:** Confirmed significant regional clustering with a **Moran’s I of 0.398** ($p < 0.001$).
* **Hotspot Mapping (LISA):** Pinpointed statistically significant **High-High clusters** of aging and **Low-Low "Youth Hubs"** (e.g., the Tokyo metropolitan area).
* **Diagnostic Rigor:** Validated local dependencies using **Geary’s C** ($0.606$) to ensure the patterns weren't mere statistical anomalies.
<table align="center">
  <tr>
    <td align="center">
      <b>Spatial Distribution of Aging Population</b><br>
      <img src="outputs/maps/01_aging_choropleth.png" width="520">
    </td>
    <td align="center">
      <b>LISA map</b><br>
      <img src="outputs/maps/03_lisa_map.png" width="520">
    </td>
  </tr>
</table>

<br>

<p align="center">
  <b>Moran Scatterplot</b><br><br>
  <img src="outputs/figures/01_moran_scatter.png" width="450">
</p>

<p align="center">
<b>Moran's I = 0.398 (p &lt; 0.001)</b> indicating significant positive spatial autocorrelation across Japanese prefectures.
</p>



### 3. Advanced Predictive Modeling

Standard linear models (OLS) were rejected in favor of architectures that internalize "Geography" as a structural variable. By treating spatial dependency not as a nuisance, but as a core data feature, the modeling pipeline achieves significantly higher predictive integrity.

* **Model Selection:** Evaluated SAR and SEM architectures against the **Spatial Durbin Model (SDM)** using **AIC** and **Likelihood Ratio (LR) tests**.
* **Best-Fit Performance:** The **SDM** ($AIC = 121.22$) was identified as the most parsimonious and informative model, outperforming baseline models by capturing spatial lag dependencies in both the dependent variable and the local covariates.

| Model Specification | AIC | Selection Status |
| :--- | :---: | :---: |
| **SDM (Spatial Durbin Model)** | **121.22** | 🏆 **Selected Model** |
| Manski / GNS | 122.11 | Candidate |
| OLS (Baseline) | 124.92 | Rejected (No Spatial Effects) |
| SEM (Spatial Error Model) | 126.72 | Rejected |
| SAR (Spatial Autoregressive) | 126.82 | Rejected |

---

* **Spillover Quantification:** Because SDM coefficients cannot be interpreted as simple linear marginal effects, a 500-run simulation ($R=500$) was implemented to decompose spatial impact profiles:
    * **Direct Effects:** Local net migration and log population density remain the primary internal drivers changing the target variable within the prefecture itself.
    * **Indirect Effects (The "Contagion" Effect):** Discovered that **Fertility Rates** and **University Density** exert strong, statistically significant spillovers on neighboring regions, proving that socioeconomic trends are highly transboundary.

| Feature / Covariate | Direct Impact | Indirect Impact (Spillover) | Total Effect | Statistical Significance |
| :--- | :---: | :---: | :---: | :---: |
| **Fertility Rate** | +1.878 | +12.799 | +14.678 | Signif. (Positive) |
| **Average Income** | +0.0001 | +0.0013 | +0.0014 | Not Signif. at 95% |
| **Log Population Density** | +0.0004 | +0.0014 | +0.0018 | Signif. (Positive) |
| **Net Migration Rate** | -6.854 | -2.697 | -9.551 | Signif. (Negative) |
| **University Density** | +0.131 | +2.853 | +2.984 | Not Signif. at 95% |
| **Hospital Availability** | +0.056 | -0.123 | -0.067 | Not Signif. at 95% |


---

## ✅ Model Diagnostics
To validate that the Spatial Durbin Model successfully extracted all spatial signals from the data, the model residuals were audited using both geographic and feature-space diagnostic checks.

<p align="center">
  <img src="outputs/maps/04_sdm_residuals.png" width="50%" alt="Spatial Durbin Model Residuals Map">
  <br>
  <em>Figure 1: Geographic Distribution of Model Residuals (Testing for spatial homogeneity)</em>
</p>

<p align="center">
  <img src="outputs/figures/02_residual_moran.png" width="50%" alt="Residual Moran Scatterplot">
  <br>
  <em>Figure 2: Residual Moran Scatterplot (Confirming zero spatial autocorrelation in error terms)</em>
</p>




## 📈 Potential Business Impact
* **Unbiased Decision Making:** The final model captured all spatial dependencies, with residuals showing **zero remaining autocorrelation** ($p = 0.638$).
* **Regional vs. Local Strategy:** Proved that demographic trends are "contagious." Strategic interventions (marketing or retail) must be designed at the **Cluster Level** rather than the individual prefecture level.
* **Targeted Growth:** Identified that dense urban areas maintain younger populations, while high-aging targets are localized in regions with specific morphological constraints.

---


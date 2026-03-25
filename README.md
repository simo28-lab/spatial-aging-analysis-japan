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

## 🛰 Strategic Workflow & Methodology

### 1. Geospatial Data Engineering
A robust spatial infrastructure was built to account for Japan's unique physical geography:
* **Terrain Impact Analysis:** Integrated Digital Elevation Models (DEM) to generate **Slope** and **Hillshade** layers. This allows for the analysis of how rugged morphology restricts urban density and service accessibility.
* **Data Pipeline Optimization:** Automated nomenclature harmonization and spatial joins to ensure 100% data integrity across the archipelago.
* **Contiguity Modeling:** Structured a precise **Spatial Weight Matrix (W)**, focusing on mainland connectivity to eliminate noise from isolated island geographies.

### 2. Exploratory Spatial Data Analysis (ESDA)
* **Cluster Identification:** Confirmed significant regional clustering with a **Moran’s I of 0.398** ($p < 0.001$).
* **Hotspot Mapping (LISA):** Pinpointed statistically significant **High-High clusters** of aging and **Low-Low "Youth Hubs"** (e.g., the Tokyo metropolitan area).
* **Diagnostic Rigor:** Validated local dependencies using **Geary’s C** ($0.606$) to ensure the patterns weren't mere statistical anomalies.

### 3. Advanced Predictive Modeling
Standard linear models (OLS) were rejected in favor of models that internalize "Geography" as a variable:
* **Model Selection:** Evaluated SAR and SEM architectures against the **Spatial Durbin Model (SDM)** using **AIC** and **Likelihood Ratio (LR) tests**.
* **Best-Fit Performance:** The **SDM** ($AIC = 121.22$) was identified as the most parsimonious and informative model.
* **Spillover Quantification:** * **Direct Effects:** Local net migration and population density remain the primary internal drivers.
    * **Indirect Effects (The "Contagion" Effect):** Discovered that **Fertility Rates** and **University Density** exert strong spillovers on neighboring regions.

---

## 📈 Potential Business Impact
* **Unbiased Decision Making:** The final model captured all spatial dependencies, with residuals showing **zero remaining autocorrelation** ($p = 0.638$).
* **Regional vs. Local Strategy:** Proved that demographic trends are "contagious." Strategic interventions (marketing or retail) must be designed at the **Cluster Level** rather than the individual prefecture level.
* **Targeted Growth:** Identified that dense urban areas maintain younger populations, while high-aging targets are localized in regions with specific morphological constraints.

---


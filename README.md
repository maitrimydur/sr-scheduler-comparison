# SM-2 vs. Cognitive-Load Adaptive Spaced-Repetition

**R simulations & analysis comparing the classic SM-2 scheduler with a cognitive-load–adaptive variant.**

---

## 📋 Overview

This project implements two spaced-repetition schedulers in R:

1. **SM-2** (SuperMemo-2): the standard ease-factor algorithm  
2. **CLoad**: an adaptive variant that adjusts intervals based on simulated “cognitive load”

We run synthetic cohort simulations (N users × M cards) and analyze:
- Day-8 recall accuracy (t-test & Cohen’s d)  
- Learning curves over days (mixed-ANOVA)  
- Self-efficacy pre/post comparisons  
- Retention curves (ggplot2)

---

## 📂 Folder Structure

    ├── README.md
    ├── remindXR-study.Rproj
    ├── data/
    │   ├── cards.csv
    │   ├── day8.csv
    │   ├── pt.csv
    │   ├── logs.csv
    │   ├── selfeff.csv
    │   ├── def_pt.rds
    │   └── all_analysis_data.RData
    ├── R/
    │   ├── schedulers.R          # SM-2 & CLoad functions
    │   └── simulate_cohort.R     # simulate_study() wrapper
    ├── analysis/
    │   ├── analysis.Rmd          # statistical tests & plots
    │   └── analysis.html         # knitted output


---

## 🚀 Getting Started

### Prerequisites

- R (≥ 4.0)  
- RStudio (recommended)  
- Required packages:
  ```r
  install.packages(c(
    "dplyr", "magrittr", "simstudy",
    "knitr", "rmarkdown", "ggplot2", "lme4", "effsize"
  ))

---

## Simulation
1. Open the project file `remindXR-study.Rproj` in RStudio.
2. Source the scheduler functions and simulate:

    ```r
    source("R/schedulers.R")
    source("R/simulate_cohort.R")

    cards_df <- read.csv("data/cards.csv")
    logs <- simulate_study(cards_df, days = c(0,1,3,5,7,8))
    head(logs)

## Analysis
1. In the **analysis/** directory, open analysis.Rmd.
2. Knit to HTML or PDF to reproduce all:
    - Day-8 t-test & Cohen's d
    - Mixed-ANOVA on accuracy trends
    - Self-efficacy pre/post Wilcoxon test
    - Retention curves (ggplot2)
3. View the finished report at `analysis/analysis.html`

---

## 📊 Data
- **cards.csv**: initial deck definitions
- **day8.csv**: summary recall percentages
- **logs.csv**: long-form review logs (all days)
- **selfeff.csv**: self-efficacy pre/post data
- **pt.csv**: participant metadata
- **def_pt.rds, all_analysis_data.RData**: serialized R objects for quick load

---

## 🛠️ Structure & Extensibility
- **R/schedulers.R**:
    - `sm2(ease, q, interval_prev)`
    - `cload(ease, q, load, interval_prev)`
- **R/simulate_cohort.R**:
    - `simulate_study(cards_df, days)` drives the day-by-day review loop
- **analysis/analysis.Rmd**:
    - Organize code chunks for reproducible figures and tables

---
## 📄 License
This work is licensed under the **MIT License**. For details, see the [LICENSE](https://rem.mit-license.org/).

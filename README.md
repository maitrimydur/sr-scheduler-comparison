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
│ ├── cards.csv
│ ├── day8.csv
│ ├── pt.csv
│ ├── logs.csv
│ ├── selfeff.csv
│ ├── def_pt.rds
│ └── all_analysis_data.RData
├── R/
│ ├── schedulers.R # SM-2 & CLoad functions
│ └── simulate_cohort.R # simulate_study() wrapper
├── analysis/
│ ├── analysis.Rmd # statistical tests & plots
│ └── analysis.html # knitted output

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


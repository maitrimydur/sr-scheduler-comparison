# R/simulate_cohort.R

# load dependencies
library(dplyr)
library(magrittr)
library(simstudy)

# source schedulers
source("R/schedulers.R")

# simulate_study: runs spaced-repetition reviews over specified days
simulate_study <- function(cards_df, days = c(0, 1, 3, 5, 7, 8)) {
  logs <- vector("list", length(days))
  names(logs) <- as.character(days)
  
  for (day in days) {
    # mark due cards
    cards_df <- cards_df %>% mutate(is_due = due_day <= day)
    
    # run reviews for due cards
    reviews <- cards_df %>%
      filter(is_due) %>%
      rowwise() %>%
      mutate(
        load          = clamp(runif(1, .2, .8) + day/10 + rnorm(1, 0, .05), 0, 1),
        p_correct     = plogis((ease - 1.8) * 1.5 - load * 2),
        correct       = rbinom(1, 1, p_correct),
        q             = ifelse(correct == 1, sample(3:5, 1), sample(0:2, 1)),
        ease_new      = if (arm == 0) sm2(ease, q, interval)[["ease"]]
        else          cload(ease, q, load, interval)[["ease"]],
        interval_new  = if (arm == 0) sm2(ease, q, interval)[["interval"]]
        else          cload(ease, q, load, interval)[["interval"]],
        due_new       = day + interval_new
      ) %>%
      ungroup()
    
    # log today’s reviews
    logs[[as.character(day)]] <- reviews %>%
      mutate(day = day) %>%
      select(id, arm, day, card_id, correct, load)
    
    # update spaced-repetition state
    cards_df <- cards_df %>%
      left_join(
        reviews %>% select(id, card_id, ease_new, interval_new, due_new),
        by = c("id", "card_id")
      ) %>%
      mutate(
        ease      = ifelse(is_due, ease_new, ease),
        interval  = ifelse(is_due, interval_new, interval),
        due_day   = ifelse(is_due, due_new, due_day)
      ) %>%
      select(-is_due, -ease_new, -interval_new, -due_new)
  }
  
  # combine logs from all days
  bind_rows(logs)
}

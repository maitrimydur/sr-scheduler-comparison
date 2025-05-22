# R/schedulers.R

# clamp: bound values between lo and hi for numeric vectors
clamp <- function(x, lo, hi) {
  pmin(hi, pmax(lo, x))
}

# SM-2 scheduler: returns updated ease factor and interval
sm2 <- function(ease, q, interval_prev) {
  # update ease
  ease_new <- ease + 0.1 - (5 - q) * (0.08 + (5 - q) * 0.02)
  ease_new <- clamp(ease_new, 1.3, 2.5)
  
  # calculate next interval using vectorized logic
  interval <- ifelse(
    q < 3,
    1,
    ifelse(
      interval_prev == 0,
      1,
      round(interval_prev * ease_new)
    )
  )
  
  list(ease = ease_new, interval = interval)
}

# Cognitive-load–adaptive scheduler
cload <- function(ease, q, load, interval_prev) {
  # update ease
  ease_new <- ease + 0.1 - (5 - q) * (0.08 + 0.02 * load)
  ease_new <- clamp(ease_new, 1.3, 2.5)
  
  # calculate next interval
  interval <- ifelse(
    q < 3,
    1,
    round(interval_prev * ease_new * (1 - load + 0.5))
  )
  
  list(ease = ease_new, interval = interval)
}

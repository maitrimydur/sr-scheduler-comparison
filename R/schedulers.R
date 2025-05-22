# R/schedulers.R

# 1) clamp must come first
clamp <- function(x, lo, hi) {
  pmin(hi, pmax(lo, x))
}

# 2) SM-2 scheduler
sm2 <- function(ease, q, interval_prev) {
  ease_new <- ease + 0.1 - (5 - q) * (0.08 + (5 - q) * 0.02)
  ease_new <- clamp(ease_new, 1.3, 2.5)
  interval  <- if (q < 3) {
    1
  } else if (interval_prev == 0) {
    1
  } else {
    round(interval_prev * ease_new)
  }
  list(ease = ease_new, interval = interval)
}

# 3) Cognitive-load scheduler
cload <- function(ease, q, load, interval_prev) {
  ease_new <- ease + 0.1 - (5 - q) * (0.08 + 0.02 * load)
  ease_new <- clamp(ease_new, 1.3, 2.5)
  interval  <- if (q < 3) {
    1
  } else {
    round(interval_prev * ease_new * (1 - load + 0.5))
  }
  list(ease = ease_new, interval = interval)
}

# R/api_helpers/03_normalize_lines.R
library(dplyr)
library(stringr)

api_find_line <- function(df, patterns) {
  rx <- paste(patterns, collapse = "|")
  df %>% filter(str_detect(line_item, regex(rx, ignore_case = TRUE)))
}

api_get_line <- function(df, patterns, label = "line item") {
  out <- api_find_line(df, patterns)
  if (nrow(out) == 0) stop("Could not find ", label, " in statement.")
  out
}

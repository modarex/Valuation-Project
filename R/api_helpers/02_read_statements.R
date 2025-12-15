# R/api_helpers/02_read_statements.R
# Read yfinance CSVs into tidy long-format tables

library(readr)
library(dplyr)
library(tidyr)

api_read_statement <- function(ticker,
                               statement = c("income", "balance", "cashflow")) {

  statement <- match.arg(statement)
  ticker <- toupper(trimws(ticker))

  file <- api_data_path(paste0(ticker, "_", statement, ".csv"))

  if (!file.exists(file)) {
    stop("Missing file: ", file,
         "\nRun api_pull_financials(ticker) first.")
  }

  raw <- read_csv(file, show_col_types = FALSE)

  tidy <- raw %>%
    rename(line_item = 1) %>%
    pivot_longer(
      cols = -line_item,
      names_to = "period",
      values_to = "value"
    ) %>%
    mutate(
      ticker = ticker,
      statement = statement,
      period = as.character(period)
    ) %>%


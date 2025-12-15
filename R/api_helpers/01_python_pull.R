# R/api_helpers/01_python_pull.R
# Run the Python yfinance pull script from R

api_pull_financials <- function(ticker, refresh = TRUE) {
  ticker <- toupper(trimws(ticker))
  if (ticker == "") stop("Ticker is empty.")

  needed <- c(
    api_data_path(paste0(ticker, "_income.csv")),
    api_data_path(paste0(ticker, "_balance.csv")),
    api_data_path(paste0(ticker, "_cashflow.csv"))
  )

  if (!refresh && all(file.exists(needed))) return(invisible(TRUE))

  dir.create(api_cfg$data_dir, showWarnings = FALSE, recursive = TRUE)

  py <- api_cfg$python
  script <- api_cfg$py_script

  if (!file.exists(script)) {
    stop("Python script not found: ", script,
         "\nExpected at: py/pull_financials.py")
  }

  cmd <- paste(
    shQuote(py),
    shQuote(script),
    shQuote(ticker),
    shQuote(api_cfg$data_dir)
  )

  status <- system(cmd)

  if (!identical(status, 0L)) {
    stop("Python pull failed.\nTry running this in Terminal:\n", cmd)
  }

  missing <- needed[!file.exists(needed)]
  if (length(missing) > 0) {
    stop("Python ran but expected files are missing:\n", paste(missing, collapse = "\n"))
  }

  invisible(TRUE)
}

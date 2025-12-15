# Valuation Toolkit (R + Python)

This project pulls financial statements using Python (yfinance) and runs analysis + dashboards in R (Shiny/Quarto).

## Structure
- `py/` Python data pull scripts
- `data/` generated CSV outputs (ignored by git)
- `R/api_helpers/` data plumbing (pull, read, normalize)
- `R/valuation/` valuation logic (DCF/WACC/etc.)
- `R/shiny/` Shiny app
- `reports/` Quarto report

## Setup (Python)
```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
python py/pull_financials.py AAPL data


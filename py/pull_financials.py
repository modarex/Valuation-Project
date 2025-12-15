import yfinance as yf
import sys
from pathlib import Path

ticker = sys.argv[1] if len(sys.argv) > 1 else "AAPL"
outdir = Path(sys.argv[2]) if len(sys.argv) > 2 else Path("data")
outdir.mkdir(parents=True, exist_ok=True)

t = yf.Ticker(ticker)

income = t.income_stmt
balance = t.balance_sheet
cashflow = t.cash_flow

income.to_csv(outdir / f"{ticker}_income.csv")
balance.to_csv(outdir / f"{ticker}_balance.csv")
cashflow.to_csv(outdir / f"{ticker}_cashflow.csv")

print(f"Saved financials for {ticker} to {outdir}")

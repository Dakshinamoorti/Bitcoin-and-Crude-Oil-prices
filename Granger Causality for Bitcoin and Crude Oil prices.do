clear all

log using "/Users/Arun/Desktop/Spring 2022/MicroEconometrics/Paper/Micro Paper.smcl", replace

import excel "/Users/Arun/Desktop/Spring 2022/MicroEconometrics/Paper/Micro Paper Weekly.xlsx", cellrange(A3:E250) first

* Setting weekly time series
tsmktim time, start (2017w29)
tsset time

* AIC/BIC to get the optimal lag 
varsoc OilPrices Bitcoin MARA BLCN, maxlag(5)

* Vector Autoregression for Granger Causality test
var OilPrices Bitcoin MARA BLCN, lags(1)
vargranger

* Graph for Non-Stationary data
tsline OilPrices, name(A1)
tsline Bitcoin, name(A2)
tsline MARA, name(A3)
tsline BLCN, name(A4)

graph combine A1 A2 A3 A4

* Checking for Stationarity
dfuller OilPrices, lags(1)
dfuller Bitcoin, lags(1)
dfuller MARA, lags(1)
dfuller BLCN, lags(1)

*Making data Stationary
gen d_OilPrices= d.OilPrices
gen d_Bitcoin= d.Bitcoin
gen d_MARA= d.MARA
gen d_BLCN= d.BLCN

* AIC/BIC to get the optimal lag
varsoc d_OilPrices d_Bitcoin d_MARA d_BLCN, maxlag(5)

* Vector Autoregression for Granger Causality test
var d_OilPrices d_Bitcoin d_MARA d_BLCN, lags(1)
vargranger

* Graph for Stationary data
tsline d_OilPrices, name(B1)
tsline d_Bitcoin, name(B2)
tsline d_MARA, name(B3)
tsline d_BLCN, name(B4)

graph combine B1 B2 B3 B4


log close

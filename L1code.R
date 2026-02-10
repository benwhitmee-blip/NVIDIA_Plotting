# The package quantmod can download financial data directly from open sources
# it will download supporting packages ttr, xts, zoo
install.packages("quantmod") 
# functions for basic properties of financial returns 
install.packages("fBasics")

# Clean the memory
rm(list = ls()) 


# Set the working directory
setwd("Desktop/QUANT/WEEK 1/")
#--------------------------------------------------------

library(quantmod)
library(fBasics)
# download daily data of NVIDIA for maximum availability
getSymbols("NVDA") 

# the downloaded NVDA is an xts object, we can use head/tail to check its entries
head(NVDA)
tail(NVDA)

# download daily data of NVDA for specified dates
getSymbols("NVDA", from = "2020-01-01", to = "2025-06-30") 

# obtain the adjusted closing price
P = NVDA$NVDA.Adjusted
head(P)
# plot the adjusted closing price
plot(P)
# export the graph to a local directory
dev.copy(pdf,'NVDA_ADJ.pdf')
dev.off()

# compute simple return
price_changes <- diff(P)
head(price_changes)
P_lag <- lag(P)
head(P_lag)
ret_s <- price_changes/P_lag
head(ret_s)

# compute continuously compounded  return (in percentages)
ret_cc <- diff(log(P))
plot(ret_cc)


# convert daily returns to to monthly returns
ret_m <- apply.monthly(ret_cc, sum)
head(ret_m)
plot(ret_m)
# convert daily returns to to yearly/annual returns
ret_y <- apply.yearly(ret_cc, sum)
head(ret_y)
plot(ret_y)


# download monthly data of NVDA for specified dates
getSymbols("NVDA", from = "2020-01-01", to = "2025-12-31", periodicity="monthly")  
head(NVDA)
# plot the adjusted closing price
P_m <- NVDA$NVDA.Adjusted
plot(P_m)
ret_m2 = diff(log(P_m))
head(ret_m2)
plot(ret_m2)


# download the treasury bill rate from FRED
getSymbols("DTB3", src="FRED")
plot(DTB3)
# what if we "sum" the daily rate?
TB3_m <- apply.monthly(DTB3, sum, na.rm=T)
plot(TB3_m)
# what if we "average" the daily rate?
TB3_m <- apply.monthly(DTB3, mean, na.rm = T)
plot(TB3_m)
# shall we "sum" or "average"?

# how about converting from monthly to yearly rate
TB3_y <- apply.yearly()
plot(TB3_y)


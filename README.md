# Crypto_Dashbord_simulator- 

the Link to the dashbord : https://lucasjeanneau.shinyapps.io/CryptoDashboard/


#1. Motivation of the dashboard.
Our idea behind this Dashboard was threefold. First, we wanted to have an overview of the
cryptocurrency market: what are the main currencies, what are their histories and how much
they cost today and how much they have costed in the past. Second, we wanted to simulate
investment strategies to have an idea of how much money could we earn (or loose) by
investing in this type of products. And last, we wanted to apply our courses of this year and
making some machine learning to see if we could correctly predict prices of crypto currencies
and optimize a portfolio as it was already done recently in the academic literature (see for
instance Hrytsiuk et al. (2019) and Aljinovic et al. (2021)).
2. Data and Methods.
To create our dataset, we use the API provided by Binance, which gave us historical data
about 6 cryptocurrencies (they are described later in this section of this document). Everyone
can easily replicate our dataset by using our open access code on GitHub
(https://github.com/medseddik1999/Crypto_Dashbord_simulator-
/blob/main/importation_coin_data.py).
Binance is the largest cryptocurrencies exchange platform in the world in terms of daily
trading volume, so they have high quality data about this market.
Our methodological choice was to download only data from 2019 (2 full years of data) to
simplify the computational part of the project, but it can be a criticized choice as we select
only years impacted by the Covid-19 outbreak. We also decided to download daily data
because we have a weak computational resource. We simplify our dashboard to host it on a
free server. At the end we only have a data frame with all prices, indictors and strategies
(167 columns).

#2.a Presentation of the cryptocurrencies used in the project

The 6 cryptocurrencies we decided to implement in our Dashboard are:

##Bitcoin (BTC):

The Bitcoin is without any doubt the most famous one. It is a crypto currency created in 2008
by Satoshi Nakamoto, a pseudonym behind which hides one or more individuals never
identified until then.
It relies on a decentralized network of computers that verify transactions between two parties,
much like a bank or central authority would.
Each new operation is added to an unfalsifiable register, the blockchain. Holding bitcoin is like
having a secret key proving to any network user that you hold this bitcoin.
The total number of bitcoins that will be put into circulation is limited to 21 million units, of which
17 million have already been created. The price of this cryptocurrency has exploded during the
last 4 years. 

##Dash:

Dash is a digital currency created in 2014 by Evan Duffield. The ambition of Dash developers
is to offer a totally decentralized digital alternative to cash, it has the same characteristics as
Bitcoin, but has a few additional features that include three of its main attributes: the fungibility,
the speed via instant transactions and the anonymity.
Indeed, unlike Bitcoin, which by nature allows any outside observer to follow peer to peer
(address-to-address) transactions, Dash offers an optional mode of anonymized transactions,
which offers users greater protection of their private life.
At the start of 2017, the Dash coin rose so much that it became the third largest cryptocurrency
by market capitalization. However, its value has dropped sharply and at present it has become
the eighteenth largest cryptocurrency in the crypto world.
Ethereum (ETH):
Ethereum is a blockchain protocol dreamed up by Vitalik Buterin, a Russian-Canadian
developer. Launched in 2015, Ethereum, the second blockchain in terms of valuation after
Bitcoin, is a decentralized exchange protocol allowing users to create smart contracts. These
smart contracts are based on a computer protocol to verify or enforce a mutual contract.
It is different from Bitcoin, which is only focused on peer-to-peer payment. Tens of thousands
of developers are building apps on Ethereum for the finance, entertainment, cloud, and real
estate industries. The Ethereum blockchain developer community is one of the largest and
most active in the world.

##0x (ZRX):

The 0x was founded in 2016 by Will Warren and Amir Bandeali.
0x is a protocol of the Ethereum blockchain which aims to facilitate decentralized transactions
through an off-chain preliminary stage. when a transaction is concluded, 0x, is submitted only
once to the Ethereum blockchain, which is significantly faster.
0x methodology is used by various apps and platforms that want access to asset exchange.
Cryptocurrency exchanges are an example of platforms based on the 0x solution.
Litecoin (LTC):
Litecoin was developed through an open-source client on GitHub on October 7, 2011, by
Charlie Lee, a former Google employee.
Bitcoin is relatively expensive and slow to transfer, while Litecoin was designed and improved
to be cheap and fast (Litecoin has a block confirmation time of 2.5 minutes, unlike Bitcoin which
takes around 10 minutes to confirm a block) so it is better positioned for everyday use.
As such, with the growing number of websites and companies accepting e-money as a form
of payment, it could be considered “real money”, rather than just a way to transfer value.

##Monero (XMR):

The Monero project was developed by a team of 7 developers, of which only 3 have a known
identity: Francisco "ArticMine" Cabañas, David Latapie and Riccardo Spagni, who is the
current main developer, the others are only identified by pseudonyms.
Monero arrived on the cryptocurrency scene offering what was previously uncharted territory
when it was unveiled: anonymity.
The concept of complete anonymity was still theoretical when Monero was launched on April
18, 2014. The project is based on an opaque blockchain powered by the XMR token, the native
digital currency of the Monero blockchain. 


#2.b. Presentation of the indicators used in the strategies

The indicators we decided to implement are the following:

##Supertrend indicator:

  The Supertrend is an indicator which was developed by Olivier Seban a French trader. It aims
to detect price trends and is constructed using only two parameters - period and multiplier
The first step is to calculate the ATR ("Average true Range" which is a measure of volatility)
over the entire historical period and then the two bands of the indicator:
     
        Up = (high + low) / 2 + multiplier x ATR(n)
        Down = (high + low) / 2 – multiplier x ATR(n)

n: ATR calculation period, typically 10
multiply: coefficient used to weight the volatility measured by the ATR. The standard formula
uses a coefficient of 3
              
              Calculation of Average True Range – [(Prior ATR x 13) + Current TR] / 14

Here, 14 indicates a period. Hence, the ATR is derived by multiplying the previous ATR with
13. Add the latest TR and divide it by period. Thus, ATR plays an important role in the
supertrend technical analysis indicator.
On the graphic representation, only the SuperTrendUp or the SuperTrendDown are displayed,
which alternate according to the following rule:
- the trend goes up when the closing price exceeds the previous value of the
SuperTrendDown.
- Conversely, it becomes bearish when the closing price goes below the previous value
level of the SuperTrendUp.
Then:
Buy signal: when the closing price exceeds the previous SuperTrendDown value.
Sell signal: when the closing price goes below the previous value level of the SuperTrendUp.
The advantage is that we have a very easy to use tool that allows you not to be against the
trend, that is to say that if you break the supertrend upwards and the trend is bullish, you must
buy , and if you break the supertrend on the downside, you have to speculate on the downside
since the trend is down.
The Supertrend is particularly effective in taking large trends and holding the position
throughout without exiting on small intermediate corrections. Due to its moderate sensitivity, it
will not turn around immediately due to price volatility like other indicators can.
This sensitivity to volatility can also be refined by adjusting its coefficient (which is 3 as
standard).
In addition to being able to generate buy/sell signals and identify supports and resistances, the
use of the Supertrend can also be considered to set protective stops: in this case, the indicator
will be used as a "trailing stop "which sticks to the trend. Once in a buying position, for example,
you can set your safety stop at the level of the lower limit of the Supertrend. If the latter is
depressed downward, it indicates a bearish trend reversal. The indicator reverses and it is
preferable to close out its buying position.
The strategy:
We build three deferent super trend direction and:

 ➔ We buy when sum(directions) > 1
 ➔ We sell when sum(directions) <1
We can add also some additional condition to have more precision. 


TRIX:
The Triple Exponential Moving Average (TRIX) is a powerful technical analysis tool designed
to help traders determine the momentum of a price as well as identify overbought and oversold
conditions of an underlying financial asset.
TRIX was developed by Jack Hutson in the early 80s and, as the name suggests, it is used to
show the rate of change of an exponentially smoothed triple moving average.
TRIX can be used both as an oscillator and as a momentum indicator. When used as an
oscillator, it shows potential peak and trough price areas; and when used as a momentum (or
trend follower) indicator, it can filter out price spikes that are irrelevant to the overall prevailing
trend.
TRIX has also been described as the “impulse indicator” which is able to signal when there is
a rising or falling momentum in the market.
The TRIX method starts with a simple moving average line of closing prices. This is the first
set of data in the TRIX calculation. Next, we need to calculate the simple moving average of
the first series at the chosen period. This forms the second set of data. Finally, we calculate
the exponential moving average (EMA) of the second series. This results in the third smoothed
series, known as DX.
After calculating the third series, the next step is to calculate its first derivative, or rate of
change. From this we get the TRIX value:
TRIX = (DX i+1 – DX i ) / DX i+1
Signal = EMA(TRIX)
- A positive TRIX line means there is bullish momentum
- A negative TRIX line means there is bearish momentum
- A large positive TRIX means the market is overbought
- A large negative TRIX means the market is oversold
- A crossing of the TRIX line and the signal line signifies a trend reversal
- A TRIX zero-line crossover usually occurs after a trend swing
The strategy:
 ➔ We buy when TRIX >Signal
 ➔ We sell when TRIX < Signal
We can add also some additional condition to have more precision.

##Awesome Oscillator (AO):

The AO is a popular market momentum indicator developed by American financial analyst Bill
Williams. It is an unlimited indicator anchored around a zero line and displayed as a histogram
of the average of two simple moving averages (SMA), one covering recent momentum and the
other a longer time frame of the market.
Traders often use the AO along with other indicators to confirm bullish and bearish trends and
predict possible trend reversals.
The awesome oscillator looks at the last five bars on a candlestick chart in comparison with
the previous 34. The value is then calculated by the difference in simple moving average (SMA)
over these two timeframes. The awesome oscillator formula is as follows:
    Median price = (High price of a session + low price of a session) ÷ 2
    Awesome oscillator = 5 period simple moving average (median price) – 34 period simple
moving average (median price)
NOTE: The simple moving average is determined by adding the median price for each day in
the period and dividing it by the total number of days in that period.
The price movements are then plotted on the histogram according to the two SMAs according
to the comparison of two simple moving averages.
When the five-day SMA is above the 34 period SMA, the value generated in the histogram is
above the zero line and a bull market is indicated.
When the opposite situation occurs and the value of the histogram falls below the zero line,
the short-term average is below the long-term average and a bear market is indicated.
 The strategy:
We build three deferent super trend direction and:

 ➔ We buy when AO ≥ 0
 ➔ We sell when AO< 0 
We can add also some additional condition to have more precision.


#2.c. Optimization of parameters:

In this part, we are going to deal with optimization part where we must find a good parameter
for each indicator for each strategy. So, the best way to find those parameters is the
simulation with all possible combinations of this parameters and see the result of each
combination before select the optimum. But we must split dataset to many data set to test
this parameter in another environment then training. in this case we spelt dataset by two
datasets. So, the first training and second testing (more you split, more you get precision in
parameters). but in our case, we just show the technical tools and algorithms to do this
optimization and our parameters may be not the best, but they do well. In The train
Part we simulate a strategy in the market for each parameter and we take a result of
simulation into a data frame which store all parameters combinations and their result. In the
test and validation part we do the same with test data set and validation we use plots or
queries for example we select the best parameters for train and test data and if there is a
similar row into this data frames. We put parameters of this row as the optimum of the
strategy indicators.  

#2.d. Prediction
Our idea was to build a model that will be capable to predict the feature values of the
portfolio by predicting the prices of each coin separately. The prediction of time series is
always a task that requires a preprocessing such as looking for trends, for seasonality and
for stationarity in data. Once this task is done, we can start with model construction.
For our dashboard we have used an ARIMA model, ARIMA stands for Autoregressive
Integrated Moving Average. ARIMA models could be used only in cases where we have a
non-seasonal data set, for our data this is the case for our data set. However, if the data set
contains seasonality in place of SARIMA (Seasonal ARIMA) models can be used in place of
ARIMA.
But how does ARIMA work?
An ARIMA model is described by p, d and q
P is the Auto Regressive parameter that gives us a number of lags of Y to be used in
predictions, q at the other hand gives us the number of lags for the forecast errors. Lastly d is
the order of differencing. As we already mentioned a data must have been stationary, if this
is not be case stationarity will be obtained through differentiation. ARIMA model is actually a
linear combination of Auto Regressive (AR) and Moving Average (MA) terms and it can be
represented by the following equation:


𝑌𝑡 = ∑(𝛽𝑖 ∗ 𝑌𝑡−𝑖) +𝑝𝑖=𝑑∑(𝜑𝑗 ∗ 𝜀𝑡−𝑗 )𝑞𝑗=𝑑

Where 𝑌𝑡−𝑖 are all lagged prediction going from d to t-p and 𝜀𝑡−𝑗 are all lagged forecast errors
going from d to t-q.  

#4. Limitations.

If we must criticize our project, we could make the following remarks:
➔ We use days as an interval between items. It can be a limitation because we miss some
precision.
➔ We didn’t have experience before in Machine learning for time series, so our prediction is
poor.
➔ Some technical problem in dashboards and errors.
➔ Optimization is not the best because we didn’t split data set by more than two.

#5. Discussion and Conclusion.

Globally, even if there is still errors/bug in the Dashboard, we are quite satisfied of the work
we did. The only things we didn’t add to the project is mainly due to time constraint. If we had
one or two months more and no other courses to deal with, we could add more ambitious
features, like the Portfolio one.
We all learned a lot by working on this Dashboard (about the crypto market, the time series
analysis, shiny,…) and we really have the ambition to make it useful to begin in this domain. 





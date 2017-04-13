# sentiment_comments
Sentiment analysis of heise online comments

A small and dirty script performing a sentiment analysis on ~2300 comments from Heise online. The JSON File is due to copyright issues not included.

The lexical sentiment analysis is based on SentiWS, published by Universität Leipzig under the [Creative Commons Attribution-Noncommercial-Share Alike 3.0 Unported License](http://creativecommons.org/licenses/by-nc-sa/3.0/). Also downloadable [here](http://wortschatz.uni-leipzig.de/de/download).

- **reshapeSentiWS.R** creates a file like new_negativ/positiv.csv out of the SentiWS-Dictionary.
- **sentiment.R** performs the actual sentiment analysis.

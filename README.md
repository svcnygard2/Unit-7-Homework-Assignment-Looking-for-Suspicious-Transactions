# Unit-7-Homework-Assignment-Looking-for-Suspicious-Transactions
- Fraud is everywhere these days, whether you are a small taco shop or a large international business.  Many instances of fraud detection still require strong data analytics to find abnormal charges.
- With my python and SQL skills I will analyze historical credit card transactions and consumption patterns in order to identify possible fraudulent transactions.

## Data Analysis Questions
- How can you isolate (or group) the transactions of each cardholder?
    The answer can be seen from the view 'select * from cardholder_transactions'.
- Consider the time period 7:00 a.m. to 9:00 a.m.
    - What are the 100 highest transactions during this time period?
        The answer can be seen from the view 'select * from highest_100_transactions'.
    - Do you see any fraudulent or anomalous transactions?
        I do see some fraudulent or anomalous transactions.
    - If you answered yes to the previous question, explain why you think there might be fraudulent transactions during this time frame.
        There are a couple cards listed that have multiple purchases of up to and more than to $1,000.  I do not know why a transaction of that amount is being made that early in the morning other than it's being stolen.

- Some fraudsters hack a credit card by making several small payments (generally less than $2.00), which are typically ignored by cardholders. Count the transactions that are less than $2.00 per cardholder. Is there any evidence to suggest that a credit card has been hacked? Explain your rationale.
    The top 5 card holders all have around 20 purchases that are $2 or less so that is pretty odd and could mean that there is some unwanted activity.
    - What are the top five merchants prone to being hacked using small transactions?
        The answer can be seen from the view 'small_transactions_m'.
- Once you have a query that can be reused, create a view for each of the previous queries.
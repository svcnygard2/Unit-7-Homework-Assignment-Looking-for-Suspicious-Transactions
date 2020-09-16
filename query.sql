--- This is the query.

--- Base Columns
select * from transaction
select * from merchant
select * from merchant_category
select * from credit_card
select * from card_holder

--- Isolated (or group) the transactions of each cardholder.
select * from cardholder_transactions
--- Highest 100 Transactions over the 7am-9am time period.
select * from highest_100_transactions
--- Transactions that are $2.00 or less per cardholder.
select * from small_transactions_ch
--- Top 5 merchants prone to being hacked using small transactions.
select * from small_transactions_m
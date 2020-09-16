--- This is the schema.

--- Drop views
DROP VIEW cardholder_transactions
DROP VIEW highest_100_transactions
DROP VIEW small_transactions_ch
DROP VIEW small_transactions_m

--- Drop columns
DROP TABLE IF EXISTS card_holder;
DROP TABLE IF EXISTS credit_card;
DROP TABLE IF EXISTS merchant;
DROP TABLE IF EXISTS merchant_category;
DROP TABLE IF EXISTS transaction;

---Views creations
---Isolate transactions of each cardholder.
create view cardholder_transactions as
select name, sum(amount) from transaction as t
JOIN credit_card as cc ON t.t_card = cc.card
JOIN card_holder as ch ON cc.id_card_holder = ch.ch_id
group by name
order by sum(amount) desc;

---100 highest transactions from 7am-9am
create view highest_100_transactions as
select * from transaction 
where date_part('hour', date) between 7 and 8
order by amount desc limit 100;

---Count transactions that are less than $2, per card holder.
create view small_transactions_ch as
select name, count(amount) from transaction as t
JOIN credit_card as cc ON t.t_card = cc.card
JOIN card_holder as ch ON cc.id_card_holder = ch.ch_id
where amount < 2
group by name
order by count(amount) desc;

---Top 5  Merchants prone to being hacked using small transactions (under $2).
create view small_transactions_m as
select m_name, count(amount) from transaction as t
JOIN merchant as m ON t.id_merchant = m.m_id
where amount < 2
group by m_name
order by count(amount) desc;

--- Table creations with foreign and primary keys
CREATE TABLE "transaction" (
    "t_id" serial   NOT NULL,
    "date" timestamp   NOT NULL,
    "amount" float   NOT NULL,
    "t_card" varchar(20)   NOT NULL,
    "id_merchant" int   NOT NULL,
    CONSTRAINT "pk_transaction" PRIMARY KEY (
        "t_id"
     )
);

CREATE TABLE "card_holder" (
    "ch_id" serial   NOT NULL,
    "name" varchar(75)   NOT NULL,
    CONSTRAINT "pk_card_holder" PRIMARY KEY (
        "ch_id"
     )
);

CREATE TABLE "credit_card" (
    "card" varchar(20)   NOT NULL,
    "id_card_holder" int   NOT NULL,
    CONSTRAINT "pk_credit_card" PRIMARY KEY (
        "card"
     )
);

CREATE TABLE "merchant_category" (
    "mc_id" serial   NOT NULL,
    "mc_name" varchar(60)   NOT NULL,
    CONSTRAINT "pk_merchant_category" PRIMARY KEY (
        "mc_id"
     )
);

CREATE TABLE "merchant" (
    "m_id" serial   NOT NULL,
    "m_name" varchar(75)   NOT NULL,
    "id_merchant_category" int   NOT NULL,
    CONSTRAINT "pk_merchant" PRIMARY KEY (
        "m_id"
     )
);

ALTER TABLE "transaction" ADD CONSTRAINT "fk_transaction_card" FOREIGN KEY("t_card")
REFERENCES "credit_card" ("card");

ALTER TABLE "transaction" ADD CONSTRAINT "fk_transaction_id_merchant" FOREIGN KEY("id_merchant")
REFERENCES "merchant" ("m_id");

ALTER TABLE "credit_card" ADD CONSTRAINT "fk_credit_card_id_card_holder" FOREIGN KEY("id_card_holder")
REFERENCES "card_holder" ("ch_id");

ALTER TABLE "merchant" ADD CONSTRAINT "fk_merchant_id_merchant_category" FOREIGN KEY("id_merchant_category")
REFERENCES "merchant_category" ("mc_id");

--- Card holder 18 and 2 transactions
select * from transaction as t
join credit_card as cc on t.t_card = cc.card
where id_card_holder = 18;

select * from transaction as t
join credit_card as cc on t.t_card = cc.card
where id_card_holder = 2;

--- Months 1 through 6 of card holder 25 (purchases at a restaurant)
---Month 1-6
select date, t_id, m_name, amount, card from transaction as t
join credit_card as cc on t.t_card = cc.card
join merchant as m on t.id_merchant = m.m_id
join merchant_category as mc on m.id_merchant_category = mc.mc_id
where id_card_holder = 25 and date_part('month', date) between 1 and 6 and
mc_name = 'restaurant';

---Month 1
select date, t_id, m_name, amount, card from transaction as t
join credit_card as cc on t.t_card = cc.card
join merchant as m on t.id_merchant = m.m_id
join merchant_category as mc on m.id_merchant_category = mc.mc_id
where id_card_holder = 25 and date_part('month', date) = 1 and
mc_name = 'restaurant';

---Month 2
select date, t_id, m_name, amount, card from transaction as t
join credit_card as cc on t.t_card = cc.card
join merchant as m on t.id_merchant = m.m_id
join merchant_category as mc on m.id_merchant_category = mc.mc_id
where id_card_holder = 25 and date_part('month', date) = 2 and
mc_name = 'restaurant';

---Month 3
select date, t_id, m_name, amount, card from transaction as t
join credit_card as cc on t.t_card = cc.card
join merchant as m on t.id_merchant = m.m_id
join merchant_category as mc on m.id_merchant_category = mc.mc_id
where id_card_holder = 25 and date_part('month', date) = 3 and
mc_name = 'restaurant';

---Month 4
select date, t_id, m_name, amount, card from transaction as t
join credit_card as cc on t.t_card = cc.card
join merchant as m on t.id_merchant = m.m_id
join merchant_category as mc on m.id_merchant_category = mc.mc_id
where id_card_holder = 25 and date_part('month', date) = 4 and
mc_name = 'restaurant';

---Month 5
select date, t_id, m_name, amount, card from transaction as t
join credit_card as cc on t.t_card = cc.card
join merchant as m on t.id_merchant = m.m_id
join merchant_category as mc on m.id_merchant_category = mc.mc_id
where id_card_holder = 25 and date_part('month', date) = 5 and
mc_name = 'restaurant';

---Month 6
select date, t_id, m_name, amount, card from transaction as t
join credit_card as cc on t.t_card = cc.card
join merchant as m on t.id_merchant = m.m_id
join merchant_category as mc on m.id_merchant_category = mc.mc_id
where id_card_holder = 25 and date_part('month', date) = 6 and
mc_name = 'restaurant';
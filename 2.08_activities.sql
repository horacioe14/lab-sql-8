#1 In this activity, we will be using the table district from the bank database 
# and according to the description for the different columns:

#1 A4: no. of inhabitants
use bank;
select *
from bank.district;

select district.A4, district.A9, district.A10, district.A11, district.A12, rank() over (order by district.A4 desc) as 'Rank'
from bank.district;

# A 9: no. of cities
# A10: the ratio of urban inhabitants
# A11: average salary
# A12: the unemployment rate

# 1. Rank districts by different variables.
select district.A4, district.A9, district.A10, district.A11, district.A12, rank() over (order by district.A4 desc) as 'Rank'
from bank.district;


select district.A4, district.A9, district.A10, district.A11, district.A12, rank() over (order by district.A11 desc) as 'Rank'
from bank.district;


# 2.Do the same but group by region.


select district.A3, district.A4, district.A9, district.A10, district.A11, district.A12, dense_rank() over (partition by district.A3 order by district.A4 desc) as 'Rank'
from bank.district;


select district.A3, district.A4, district.A9, district.A10, district.A11, district.A12, dense_rank() over (partition by district.A3 order by district.A11 desc) as 'Rank'
from bank.district;

# 3. Use the transactions table in the bank database to find the Top 20 account_ids based on the amount.
select trans.account_id, trans.amount, rank() over (order by trans.amount desc) as 'Rank'
from bank.trans
limit 20;



# 4. Illustrate the difference between rank() and dense_rank().
select trans.account_id, trans.amount, dense_rank() over (order by trans.amount desc) as 'Top20_Dense',  rank() over (order by trans.amount desc) as 'Top20'
from bank.trans
limit 20;



# Get a rank of districts ordered by the number of customers.
select a.A2 as district_name, count(client_id), dense_rank() over (order by count(client_id)) as Count_Rank
from bank.district as a
join bank.client as b
on a.A1=b.district_id
group by a.A2;


# Get a rank of regions ordered by the number of customers.
select a.A3 as district_region, count(client_id), rank() over (order by count(client_id)) as Count_Rank
from bank.district as a
join bank.client as b
on a.A1=b.district_id
group by a.A3;


# Get the total amount borrowed by the district together with the average loan in that district.
select A2 as district_name, district_id, round(avg(amount),2) as Avg_Loan, sum(amount) as total_loan_amount
from bank.loan as l
join bank.account as a
on l.account_id = a.account_id
join bank.district as d
on d.A1 = a.district_id
group by a.district_id
order by a.district_id;


select sum(amount) as TotalAmount, avg(amount) as AvgLoan, district_id from disp a
join loan l on a.account_id = l.account_id
join client d on a.client_id = d.client_id
group by district_id
order by district_id;


# Get the number of accounts opened by district and year.
select A2 as district_name, district_id, substr(date, 1,2) as 'Year', count(a.account_id) as accounts_per_district
from bank.account as a
join bank.district as d 
on a.district_id = d.A1
group by a.district_id, 'Year' 
order by a.district_id;

select count(account_id) 
from bank.account;

select a.account_id, district_id, substr(date, 1,2) as 'Year', count(a.account_id) as NumberofAccounts from disp a
join client d on a.client_id = d.client_id
join trans l on a.account_id = l.account_id
group by district_id, 'Year'
order by district_id;



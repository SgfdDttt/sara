% Text
% Alice got married on Dec 10th, 2009. Alice's gross income for the year 2016 is $554313. Alice files separately and takes the standard deduction. Her husband's income in 2016 is $56298 and he takes itemized deductions of $4421.

% Question
% How much tax does Alice have to pay in 2016? $207772

% Facts
:- [statutes/prolog/init].
marriage_(alice_marriage).
agent_(alice_marriage,alice).
agent_(alice_marriage,spouse).
start_(alice_marriage,"2009-12-10").
income_(alice_income_2016).
agent_(alice_income_2016,alice).
amount_(alice_income_2016,554313).
start_(alice_income_2016,"2016-12-31").
income_(spouse_income_2016).
agent_(spouse_income_2016,spouse).
amount_(spouse_income_2016,56298).
start_(spouse_income_2016,"2016-12-31").
deduction_(spouse_itemized_deduction).
agent_(spouse_itemized_deduction,spouse).
start_(spouse_itemized_deduction,"2016-01-01").
amount_(spouse_itemized_deduction,4421).

% Test
:- tax(alice,2016,207772).
:- halt.

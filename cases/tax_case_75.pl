% Text
% Alice shares a house with her father Bob since 2007. Alice pays for 75% of the costs of the house, while Charlie, her brother, pays for the remaining 25%. Alice's gross income for the year 2012 was $67285 and Charlie's was $56174. Alice is allowed itemized deductions of $17817.

% Question
% How much tax does Alice have to pay in 2012? $8883

% Facts
:- [statutes/prolog/init].
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,home).
start_(alice_residence,"2007-01-01").
father_(bob_father).
agent_(bob_father,bob).
patient_(bob_father,alice).
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,home).
start_(bob_residence,"2007-01-01").
payment_(alice_maintains_home).
agent_(alice_maintains_home,alice).
amount_(alice_maintains_home,75).
purpose_(alice_maintains_home,home).
start_(alice_maintains_home,Day) :- between(2007,2107,Year),
    first_day_year(Year,Day).
brother_(charlie_brother).
agent_(charlie_brother,charlie).
patient_(charlie_brother,alice).
payment_(charlie_maintains_home).
agent_(charlie_maintains_home,charlie).
amount_(charlie_maintains_home,25).
purpose_(charlie_maintains_home,home).
start_(charlie_maintains_home,Day) :- between(2007,2107,Year),
    first_day_year(Year,Day).
income_(alice_income_2012).
agent_(alice_income_2012,alice).
amount_(alice_income_2012,67285).
start_(alice_income_2012,"2012-12-31").
income_(charlie_income_2012).
agent_(charlie_income_2012,charlie).
amount_(charlie_income_2012,56174).
start_(charlie_income_2012,"2012-12-31").
deduction_(itemized_deductions).
agent_(itemized_deductions,alice).
amount_(itemized_deductions,17817).
start_(itemized_deductions,"2012-01-01").

% Test
:- tax(alice,2012,8883).
:- halt.

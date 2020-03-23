% Text
% Alice's gross income for the year 2014 is $97407. In 2014, Alice's father Bob lived at the house that Alice maintains and resides in. Alice takes the standard deduction in 2014.

% Question
% How much tax does Alice have to pay in 2014? $21452

% Facts
:- [statutes/prolog/init].
father_(bob_father).
agent_(bob_father,bob).
patient_(bob_father,alice).
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,alice_house).
start_(bob_residence,"2014-01-01").
end_(bob_residence,"2014-12-31").
payment_(alice_maintains_house).
agent_(alice_maintains_house,alice).
amount_(alice_maintains_house,1).
start_(alice_maintains_house,"2014-01-01").
purpose_(alice_maintains_house,alice_house).
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,alice_house).
start_(alice_residence,"2014-01-01").
end_(alice_residence,"2014-12-31").
income_(alice_income_2014).
agent_(alice_income_2014,alice).
amount_(alice_income_2014,97407).
start_(alice_income_2014,"2014-12-31").

% Test
:- tax(alice,2014,21452).
:- halt.

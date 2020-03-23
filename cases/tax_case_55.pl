% Text
% Alice has a son, Bob. From September 1st, 2015 to November 3rd, 2019, Alice and Bob lived in the same home, maintained by Alice. Bob was born on September 1st, 2015. Alice's gross income for the year 2017 is $545547. Alice's gross income for the year 2018 is $545947. Alice's gross income for the year 2019 is $545927.

% Question
% How much tax does Alice have to pay in 2018? $187552

% Facts
:- [statutes/prolog/init].
son_(bob_is_son).
agent_(bob_is_son,bob).
patient_(bob_is_son,alice).
start_(bob_is_son,"2015-09-01").
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,home).
start_(alice_residence,"2015-09-01").
end_(alice_residence,"2019-11-03").
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,home).
start_(bob_residence,"2015-09-01").
end_(bob_residence,"2019-11-03").
payment_(alice_maintains_home).
agent_(alice_maintains_home,alice).
purpose_(alice_maintains_home,home).
start_(alice_maintains_home,Day) :- between(2015,2019,Year), last_day_year(Year,Day).
amount_(alice_maintains_home,1).
income_(alice_income_2017).
agent_(alice_income_2017,alice).
amount_(alice_income_2017,545547).
start_(alice_income_2017,"2017-12-31").
income_(alice_income_2018).
agent_(alice_income_2018,alice).
amount_(alice_income_2018,545947).
start_(alice_income_2018,"2018-12-31").
income_(alice_income_2019).
agent_(alice_income_2019,alice).
amount_(alice_income_2019,545927).
start_(alice_income_2019,"2019-12-31").

% Test
:- tax(alice,2018,187552).
:- halt.

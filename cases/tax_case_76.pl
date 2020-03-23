% Text
% Alice, born Sep 4th, 1950, has a son, Bob, who was born January 31st, 1984. Alice and Bob share the same principal place of abode since then, which Alice maintains. Alice's gross income for the year 1997 is $172980. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 1997? $46734

% Facts
:- [statutes/prolog/init].
birth_(alice_birth).
agent_(alice_birth,alice).
start_(alice_birth,"1950-11-04").
son_(alice_and_bob).
agent_(alice_and_bob,bob).
patient_(alice_and_bob,alice).
start_(alice_and_bob,"1984-01-31").
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,alice_house).
start_(alice_residence,"1984-01-31").
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,alice_house).
start_(bob_residence,"1984-01-31").
payment_(alice_maintains_house).
agent_(alice_maintains_house,alice).
amount_(alice_maintains_house,1).
start_(alice_maintains_house,Day) :- between(1984,2084,Year),
    first_day_year(Year,Day).
purpose_(alice_maintains_house,alice_house).
income_(alice_income_1997).
agent_(alice_income_1997,alice).
amount_(alice_income_1997,172980).
start_(alice_income_1997,"1997-12-31").

% Test
:- tax(alice,1997,46734).
:- halt.

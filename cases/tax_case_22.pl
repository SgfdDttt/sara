% Text
% Alice has a son, Bob, who was born January 31st, 2014, and has lived at Alice's place since then. Alice's gross income for the year 2017 is $22895. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $2174

% Facts
:- [statutes/prolog/init].
son_(alice_and_bob).
agent_(alice_and_bob,bob).
patient_(alice_and_bob,alice).
start_(alice_and_bob,"2014-01-31").
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,alice_and_bob_home).
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,alice_and_bob_home).
payment_(alice_maintains_home).
agent_(alice_maintains_home,alice).
amount_(alice_maintains_home,1).
purpose_(alice_maintains_home,alice_and_bob_home).
start_(alice_maintains_home,"2017-12-31").
income_(alice_income).
agent_(alice_income,alice).
amount_(alice_income,22895).
start_(alice_income,"2017-12-31").

% Test
:- tax(alice,2017,2174).
:- halt.

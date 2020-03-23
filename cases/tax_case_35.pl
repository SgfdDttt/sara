% Text
% Alice's gross income for the year 2017 is $22895. In 2017, Alice takes the standard deduction. Alice has a son, Bob, who has the same principal place of abode as her in 2017 and is not married.

% Question
% How much tax does Alice have to pay in 2017? $2384

% Facts
:- [statutes/prolog/init].
income_(alice_income).
agent_(alice_income,alice).
start_(alice_income,"2017-12-31").
amount_(alice_income,22895).
son_(alice_and_bob).
agent_(alice_and_bob,bob).
patient_(alice_and_bob,alice).
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,alice_and_bob_home).
start_(alice_residence,"2017-01-01").
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,alice_and_bob_home).
start_(bob_residence,"2017-01-01").

% Test
:- tax(alice,2017,2384).
:- halt.

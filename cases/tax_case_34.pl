% Text
% Alice's gross income for the year 2017 is $22895. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $2684

% Facts
:- [statutes/prolog/init].
income_(alice_income).
agent_(alice_income,alice).
start_(alice_income,"2017-12-31").
amount_(alice_income,22895).

% Test
:- tax(alice,2017,2684).
:- halt.

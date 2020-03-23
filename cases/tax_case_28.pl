% Text
% Alice has paid wages of $53200 to Bob for work done from Feb 1st, 2017 to Sep 2nd, 2017 for domestic service. Alice's gross income in 2017 was $921324. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $344848

% Facts
:- [statutes/prolog/init].
service_(alice_employer).
patient_(alice_employer,alice).
agent_(alice_employer,bob).
start_(alice_employer,"2017-02-01").
end_(alice_employer,"2017-09-02").
purpose_(alice_employer,"domestic service").
payment_(alice_pays_bob).
agent_(alice_pays_bob,alice).
patient_(alice_pays_bob,bob).
start_(alice_pays_bob,"2017-09-02").
purpose_(alice_pays_bob,alice_employer).
amount_(alice_pays_bob,53200).
income_(alice_income).
start_(alice_income,"2017-12-31").
amount_(alice_income,921324).
agent_(alice_income,alice).

% Test
:- tax(alice,2017,344848).
:- halt.

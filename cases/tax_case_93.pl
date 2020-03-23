% Text
% Bob is Alice's father. Alice's gross income in 2015 is $311510. Bob has no income in 2015. Alice takes the standard deduction in 2015.

% Question
% How much tax does Alice have to pay in 2015? $102150

% Facts
:- [statutes/prolog/init].
father_(alice_and_bob).
agent_(alice_and_bob,bob).
patient_(alice_and_bob,alice).
income_(alice_income_2015).
agent_(alice_income_2015,alice).
start_(alice_income_2015,"2015-01-01").
end_(alice_income_2015,"2015-12-31").
amount_(alice_income_2015,311510).

% Test
:- tax(alice,2015,102150).
:- halt.

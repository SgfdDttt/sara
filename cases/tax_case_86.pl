% Text
% Bob is Alice's father. Alice has paid $45252 to Bob for work done in the year 2017.

% Question
% How much tax does Alice have to pay in 2017? $0

% Facts
:- [statutes/prolog/init].
:- [statutes/prolog/init].
father_(alice_and_bob).
agent_(alice_and_bob,bob).
patient_(alice_and_bob,alice).
service_(alice_employer).
patient_(alice_employer,alice).
agent_(alice_employer,bob).
start_(alice_employer,"2017-01-01").
end_(alice_employer,"2017-12-31").
payment_(alice_pays_bob).
agent_(alice_pays_bob,alice).
patient_(alice_pays_bob,bob).
start_(alice_pays_bob,"2017-01-01").
end_(alice_pays_bob,"2017-12-31").
purpose_(alice_pays_bob,alice_employer).
amount_(alice_pays_bob,45252).

% Test
:- tax(alice,2017,0).
:- halt.

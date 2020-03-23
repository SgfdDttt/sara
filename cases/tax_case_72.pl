% Text
% Bob is Alice's father. Alice has paid $2561 to Bob for work done from Feb 1st, 2013 to Sep 2nd, 2013, in Baltimore, Maryland, USA. Alice's gross income in 2013 is $42384. Alice takes the standard deduction in 2013.

% Question
% How much tax does Alice have to pay in 2013? $7595

% Facts
:- [statutes/prolog/init].
father_(alice_and_bob).
agent_(alice_and_bob,bob).
patient_(alice_and_bob,alice).
service_(alice_employer).
patient_(alice_employer,alice).
agent_(alice_employer,bob).
start_(alice_employer,"2013-02-01").
end_(alice_employer,"2013-09-02").
location_(alice_employer,"baltimore").
location_(alice_employer,"maryland").
location_(alice_employer,"usa").
payment_(alice_pays).
agent_(alice_pays,alice).
patient_(alice_pays,bob).
start_(alice_pays,"2013-09-02").
purpose_(alice_pays,alice_employer).
amount_(alice_pays,2561).
income_(alice_income_2013).
agent_(alice_income_2013,alice).
amount_(alice_income_2013,42384).
start_(alice_income_2013,"2013-12-31").

% Test
:- tax(alice,2013,7595).
:- halt.

% Text
% Alice, born Jun 7, 1964, has a son, Bob, born Feb 7, 1988, and they both have the same principal place of abode in 2015. Bob has a son, Charlie, born Jun 29, 2014, and they both have the same principal place of abode in 2015. Bob's gross income in 2015 is $43591. Bob takes the standard deduction.

% Question
% How much tax does Bob have to pay in 2015? $6812

% Facts
:- [statutes/prolog/init].
birth_(birth_alice).
agent_(birth_alice,alice).
start_(birth_alice,"1964-06-07").
son_(alice_and_bob).
agent_(alice_and_bob,bob).
patient_(alice_and_bob,alice).
start_(alice_and_bob,"1988-02-07").
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,home).
start_(alice_residence,"2015-01-01").
end_(alice_residence,"2015-12-31").
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,home).
start_(bob_residence,"2015-01-01").
end_(bob_residence,"2015-12-31").
residence_(charlie_residence).
agent_(charlie_residence,charlie).
patient_(charlie_residence,home).
start_(charlie_residence,"2015-01-01").
end_(charlie_residence,"2015-12-31").
son_(bob_and_charlie).
agent_(bob_and_charlie,charlie).
patient_(bob_and_charlie,bob).
start_(bob_and_charlie,"2014-06-29").
income_(bob_income).
agent_(bob_income,bob).
amount_(bob_income,43591).
start_(bob_income,"2015-12-31").

% Test
:- tax(bob,2015,6812).
:- halt.

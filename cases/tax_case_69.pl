% Text
% Alice and Bob were married from Feb 3rd, 1997 to Oct 30th, 2001. Alice's gross income for the year 2014 is $718791 and she takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2014? $264225

% Facts
:- [statutes/prolog/init].
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"1997-02-03").
end_(alice_and_bob,"2001-10-31").
income_(alice_income).
agent_(alice_income,alice).
start_(alice_income,"2014-12-31").
amount_(alice_income,718791).

% Test
:- tax(alice,2014,264225).
:- halt.

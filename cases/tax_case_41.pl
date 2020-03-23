% Text
% Alice and Bob got married on Feb 3rd, 1992. Alice was a nonresident alien until July 9th, 2014. Bob died September 16th, 2017. Alice's gross income in 2013 was $71414. Bob's income in 2013 was $56404. Alice files separately and takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2013? $17783

% Facts
:- [statutes/prolog/init].
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"1992-02-03").
nonresident_alien_(alice_is_a_nra).
agent_(alice_is_a_nra,alice).
end_(alice_is_a_nra,"2014-07-09").
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2012-04-05").
death_(bob_dies).
agent_(bob_dies,bob).
start_(bob_dies,"2017-09-16").
income_(alice_income).
agent_(alice_income,alice).
amount_(alice_income,71414).
start_(alice_income,"2013-12-31").
income_(bob_income).
agent_(bob_income,bob).
amount_(bob_income,56404).
start_(bob_income,"2013-12-31").

% Test
:- tax(alice,2013,17783).
:- halt.

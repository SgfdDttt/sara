% Text
% Alice and Charlie have a son, Bob. From September 1st, 2015 to November 3rd, 2019, Alice, Bob and Charlie lived in the same home. Alice and Charlie got married on Feb 3rd, 1992. Alice is a nonresident alien. In 2018, Alice earned $643531. Charlie had no income in 2018. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2018? $243103

% Facts
:- [statutes/prolog/init].
son_(bob_is_son).
agent_(bob_is_son,bob).
patient_(bob_is_son,alice).
patient_(bob_is_son,charlie).
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,home).
start_(alice_residence,"2015-09-01").
end_(alice_residence,"2019-11-03").
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,home).
start_(bob_residence,"2015-09-01").
end_(bob_residence,"2019-11-03").
residence_(charlie_residence).
agent_(charlie_residence,charlie).
patient_(charlie_residence,home).
start_(charlie_residence,"2015-09-01").
end_(charlie_residence,"2019-11-03").
marriage_(alice_and_charlie).
agent_(alice_and_charlie,alice).
agent_(alice_and_charlie,charlie).
start_(alice_and_charlie,"1992-02-03").
nonresident_alien_(alice_is_a_nra).
agent_(alice_is_a_nra,alice).
income_(alice_income_2018).
agent_(alice_income_2018,alice).
amount_(alice_income_2018,643531).
start_(alice_income_2018,"2018-12-31").

% Test
:- tax(alice,2018,243103).
:- halt.

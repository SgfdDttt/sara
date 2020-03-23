% Text
% Alice and Bob got married on November 23rd, 1994. Their son Charlie was born on July 5th, 2000. Bob died on March 15th, 2015. In 2017, Alice and Charlie lived in a house maintained by Alice. Alice's gross income for the year 2017 is $95129. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $19039

% Facts
:- [statutes/prolog/init].
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"1994-11-23").
son_(birth_charlie).
agent_(birth_charlie,charlie).
patient_(birth_charlie,alice).
patient_(birth_charlie,bob).
start_(birth_charlie,"2000-07-05").
death_(bob_dies).
agent_(bob_dies,bob).
start_(bob_dies,"2015-03-15").
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,home).
start_(alice_residence,"2017-01-01").
end_(alice_residence,"2017-12-31").
residence_(charlie_residence).
agent_(charlie_residence,charlie).
patient_(charlie_residence,home).
start_(charlie_residence,"2017-01-01").
end_(charlie_residence,"2017-12-31").
payment_(alice_maintains_home).
agent_(alice_maintains_home,alice).
amount_(alice_maintains_home,1).
purpose_(alice_maintains_home,home).
start_(alice_maintains_home,"2017-12-31").
income_(alice_income_2017).
agent_(alice_income_2017,alice).
start_(alice_income_2017,"2017-12-31").
amount_(alice_income_2017,95129).

% Test
:- tax(alice,2017,19039).
:- halt.

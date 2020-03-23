% Text
% Alice has paid $3200 to her father Bob for work done from Feb 1st, 2017 to Sep 2nd, 2017, in Baltimore, Maryland, USA. Alice and Charlie got married on April 5th, 2012. Alice and Charlie were legally separated under a decree of divorce on September 16th, 2017. Alice's gross income in 2017 was $756420. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $279126

% Facts
:- [statutes/prolog/init].
service_(alice_employer).
patient_(alice_employer,alice).
agent_(alice_employer,bob).
start_(alice_employer,"2017-02-01").
end_(alice_employer,"2017-09-02").
location_(alice_employer,"baltimore").
location_(alice_employer,"maryland").
location_(alice_employer,"usa").
payment_(alice_pays).
agent_(alice_pays,alice).
patient_(alice_pays,bob).
start_(alice_pays,"2017-09-02").
purpose_(alice_pays,alice_employer).
amount_(alice_pays,3200).
father_(bob_father_of_alice).
agent_(bob_father_of_alice,bob).
patient_(bob_father_of_alice,alice).
marriage_(alice_and_charlie).
agent_(alice_and_charlie,alice).
agent_(alice_and_charlie,charlie).
start_(alice_and_charlie,"2012-04-05").
legal_separation_(alice_and_charlie_divorce).
patient_(alice_and_charlie_divorce,alice_and_charlie).
agent_(alice_and_charlie_divorce,"decree of divorce").
start_(alice_and_charlie_divorce,"2017-09-16").
income_(alice_income).
agent_(alice_income,alice).
amount_(alice_income,756420).
start_(alice_income,"2017-12-31").

% Test
:- tax(alice,2017,279126).
:- halt.

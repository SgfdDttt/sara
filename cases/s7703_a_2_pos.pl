% Text
% Alice and Bob got married on April 5th, 2012. Alice and Bob were legally separated under a decree of divorce on September 16th, 2017.

% Question
% Section 7703(a)(2) applies to Alice for the year 2018. Entailment

% Facts
:- [statutes/prolog/init].
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2012-04-05").
legal_separation_(alice_and_bob_divorce).
patient_(alice_and_bob_divorce,alice_and_bob).
agent_(alice_and_bob_divorce,"decree of divorce").
start_(alice_and_bob_divorce,"2017-09-16").

% Test
:- s7703_a_2(alice,_,_,_,2018).
:- halt.

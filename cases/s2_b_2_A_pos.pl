% Text
% Alice and Bob got married on Feb 3rd, 1992. Alice and Bob were legally separated under a decree of separate maintenance on July 9th, 2014.

% Question
% Section 2(b)(2)(A) applies to Alice and Bob's marriage in 2018. Entailment

% Facts
:- [statutes/prolog/init].
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"1992-02-03").
legal_separation_(alice_and_bob_divorce).
agent_(alice_and_bob_divorce,"decree of separate maintenance").
patient_(alice_and_bob_divorce,alice_and_bob).
start_(alice_and_bob_divorce,"2014-07-09").

% Test
:- s2_b_2_A(alice_and_bob,2018).
:- halt.

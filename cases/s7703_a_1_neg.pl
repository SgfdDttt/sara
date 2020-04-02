% Text
% Alice and Bob got married on April 5th, 2012. Bob died September 16th, 2017.

% Question
% Section 7703(a)(1) applies to Alice for the year 2018. Contradiction

% Facts
:- [statutes/prolog/init].
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2012-04-05").
death_(bob_dies).
agent_(bob_dies,bob).
start_(bob_dies,"2017-09-16").

% Test
:- \+ s7703_a_1(alice,_,_,_,2018).
:- halt.

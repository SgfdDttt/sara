% Text
% Alice and Bob got married on Jan 1st, 2015. Alice and Bob file separately in 2015.

% Question
% Section 152(b)(2) applies to Alice the year 2015. Contradiction

% Facts
:- [statutes/prolog/init].
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2015-01-01").

% Test
:- \+ s152_b_2(alice,_,bob,2015).
:- halt.

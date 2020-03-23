% Text
% Alice and Bob got married on Feb 3rd, 1992. Alice was a nonresident alien until July 9th, 2014.

% Question
% Section 2(b)(2)(B) applies to Bob in 2015. Contradiction

% Facts
:- [statutes/prolog/init].
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"1992-02-03").
nonresident_alien_(alice_is_a_nra).
agent_(alice_is_a_nra,alice).
end_(alice_is_a_nra,"2014-07-09").

% Test
:- \+ s2_b_2_B(bob,alice,2015).
:- halt.

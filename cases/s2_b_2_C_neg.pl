% Text
% Alice and Bob got married on Feb 3rd, 1992. Alice was a nonresident alien. Alice died on July 9th, 2014.

% Question
% Section 2(b)(2)(C) applies to Bob in 2014. Contradiction

% Facts
:- [law/semantics/init].
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"1992-02-03").
death_(alice_dies).
agent_(alice_dies,alice).
start_(alice_dies,"2014-07-09").
end_(alice_dies,"2014-07-09").
nonresident_alien_(alice_is_a_nra).
agent_(alice_is_a_nra,alice).

% Test
:- \+ s2_b_2_C(bob,alice_and_bob,alice,2014).
:- halt.

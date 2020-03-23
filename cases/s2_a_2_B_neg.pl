% Text
% Alice and Bob got married on Feb 3rd, 1992. Alice died on July 9th, 2014. Alice was a nonresident alien since March 4th, 1990.

% Question
% Section 2(a)(2)(B) applies to Bob in 2014. Contradiction

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
nonresident_alien_(alice_is_nra).
agent_(alice_is_nra,alice).
start_(alice_is_nra,"1990-03-04").

% Test
:- \+ s2_a_2_B(bob,alice,2014).
:- halt.

% Text
% Alice and Bob got married on Feb 3rd, 1992. Alice died on July 9th, 2014. Bob married Charlie on September 14th, 2015.

% Question
% Section 2(a)(2)(A) applies to Bob in 2014. Contradiction

% Facts
:- [statutes/prolog/init].
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"1992-02-03").
death_(alice_dies).
agent_(alice_dies,alice).
start_(alice_dies,"2014-07-09").
end_(alice_dies,"2014-07-09").
marriage_(alice_and_charlie).
agent_(alice_and_charlie,charlie).
agent_(alice_and_charlie,bob).
start_(alice_and_charlie,"2015-09-14").

% Test
:- \+ s2_a_2_A(bob,alice_and_bob,2014).
:- halt.

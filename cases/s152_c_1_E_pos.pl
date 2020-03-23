% Text
% Alice has a son, Bob. From September 1st, 2015 to November 3rd, 2019, Alice and Bob lived in the same home. Bob married Charlie on October 23rd, 2018. Bob and Charlie file separate returns.

% Question
% Section 152(c)(1)(E) applies to Bob for the year 2019. Entailment

% Facts
:- [statutes/prolog/init].
son_(bob_is_son).
agent_(bob_is_son,bob).
patient_(bob_is_son,alice).
residence_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
patient_(alice_and_bob,home).
start_(alice_and_bob,"2015-09-01").
end_(alice_and_bob,"2019-11-03").
marriage_(bob_and_charlie).
agent_(bob_and_charlie,bob).
agent_(bob_and_charlie,charlie).
start_(bob_and_charlie,"2018-10-23").

% Test
:- s152_c_1_E(bob,_,2019).
:- halt.

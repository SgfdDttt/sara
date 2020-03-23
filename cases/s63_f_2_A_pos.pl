% Text
% In 2017, Alice was paid $33200. Alice and Bob have been married since Feb 3rd, 2017. Alice has been blind since March 20, 2016.

% Question
% Section 63(f)(2)(A) applies to Alice in 2017. Entailment

% Facts
:- [statutes/prolog/init].
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
amount_(alice_is_paid,33200).
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2017-02-03").
blindness_(alice_is_blind).
agent_(alice_is_blind,alice).
start_(alice_is_blind,"2016-03-20").

% Test
:- s63_f_2_A(alice,2017).
:- halt.

% Text
% In 2017, Alice was paid $33200. Alice and Bob have been married since Feb 3rd, 2017. Alice is entitled to a deduction for Bob under section 151(b). Bob had no gross income in 2017.

% Question
% Under section 63(c)(5), Bob's basic standard deduction in 2017 is equal to at most $500. Entailment

% Facts
:- discontiguous s151_b_applies/3.
:- [statutes/prolog/init].
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
amount_(alice_is_paid,33200).
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2017-02-03").
s151_b_applies(alice,bob,2017).

% Test
:- s63_c_5(bob,_,2017,500).
:- halt.

% Text
% In 2017, Alice was paid $33200 in remuneration. Alice and Bob have been married since Feb 3rd, 2017. Alice and Bob file separate returns in 2017.

% Question
% Section 63(c)(2)(A)(i) applies to Alice in 2017. Contradiction

% Facts
:- [law/semantics/init].
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
amount_(alice_is_paid,33200).
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2017-02-03").

% Test
:- \+ s63_c_2_A_i(alice,2017).
:- halt.

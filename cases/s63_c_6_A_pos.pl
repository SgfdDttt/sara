% Text
% In 2017, Alice was paid $33200. Alice and Bob have been married since Feb 3rd, 2017. Bob is allowed an itemized deduction of $4324. Alice and Bob file separate returns.

% Question
% Section 63(c)(6)(A) applies to Alice for 2017. Entailment

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
deduction_(bob_itemized_deduction).
agent_(bob_itemized_deduction,bob).
start_(bob_itemized_deduction,"2017-12-31").

% Test
:- s63_c_6_A(alice,_,_,2017).
:- halt.

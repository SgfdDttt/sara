% Text
% In 2017, Alice was paid $33200. Alice and Bob have been married since Feb 3rd, 2017. Bob earned $10 in 2017. Alice and Bob file separate returns. Alice is not entitled to a deduction for Bob under section 151.

% Question
% Section 63(c)(5) applies to Bob's basic standard deduction in 2017. Contradiction

% Facts
:- [law/semantics/init].
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
amount_(alice_is_paid,33200).
payment_(bob_is_paid).
patient_(bob_is_paid,bob).
start_(bob_is_paid,"2017-12-31").
amount_(bob_is_paid,10).
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2017-02-03").

% Test
:- \+ s63_c_5(bob,_,2017,500).
:- halt.

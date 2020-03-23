% Text
% In 2017, Alice was paid $33200. Alice and Bob have been married since Feb 3rd, 2017. Alice is entitled to an additional standard deduction of $600 each for herself and for Bob, under section 63(f)(1)(A) and 63(f)(1)(B), respectively.

% Question
% Under section 63(c)(3), Alice's additional standard deduction in 2017 is equal to $300. Contradiction

% Facts
:- discontiguous s63_f_1_A/2.
:- discontiguous s63_f_1_B/2.
:- [statutes/prolog/init].
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
amount_(alice_is_paid,33200).
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2017-02-03").
s63_f_1_A(alice,2017).
s63_f_1_B(alice,bob,2017).

% Test
:- \+ s63_c_3(alice,300,2017).
:- halt.

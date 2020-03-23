% Text
% In 2019, Alice was paid $33200. Alice is a head of household for 2019.

% Question
% Under section 63(c)(7)(i), Alice's basic standard deduction in 2019 is equal to $18000. Entailment

% Facts
:- discontiguous s2_b/4.
:- [statutes/prolog/init].
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2019-12-31").
amount_(alice_is_paid,33200).
s2_b(alice,_,_,2019).

% Test
:- s63_c_7_i(2019,18000).
:- halt.

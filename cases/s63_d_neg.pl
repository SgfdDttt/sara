% Text
% In 2017, Alice was paid $33200. She is allowed a deduction of $2000 for herself for the year 2017 under section 151(b).

% Question
% Alice's deduction for 2017 falls under section 63(d). Contradiction

% Facts
:- discontiguous s151_b/3.
:- [statutes/prolog/init].
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
amount_(alice_is_paid,33200).
s151_b(alice,2000,2017).

% Test
:- \+ s63_d(alice,_,33200,2017).
:- halt.

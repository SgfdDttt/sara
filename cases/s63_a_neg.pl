% Text
% In 2017, Alice was paid $33200. She is allowed a deduction under section 63(c) of $2000 and deductions of $4000 under section 151 for the year 2017.

% Question
% Under section 63(a), Alice's taxable income in 2017 is equal to $31200. Contradiction

% Facts
:- discontiguous s63_c/3.
:- discontiguous s151/5.
:- [statutes/prolog/init].
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
amount_(alice_is_paid,33200).
s63_c(alice,2017,2000).
s151(alice,4000,_,_,2017).

% Test
:- \+ s63_a(alice,2017,31200).
:- halt.

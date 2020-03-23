% Text
% In 2017, Alice was paid $33200 in remuneration. She is allowed deductions under section 63(c)(3) of $1200 for the year 2017.

% Question
% Alice's deduction for 2017 falls under section 63(d)(2). Contradiction

% Facts
:- discontiguous s63_c_3/4.
:- [statutes/prolog/init].
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
amount_(alice_is_paid,33200).
s63_c_3(alice,_,1200,2017).

% Test
:- \+ s63_d_2(alice,_,[1200],2017).
:- halt.

% Text
% In 2017, Alice was paid $33200. She is allowed a deduction under section 63(c)(1) of $2000 for the year 2017, and no deduction under section 151. Alice decides not to itemize her deductions.

% Question
% Under section 63(b), Alice's taxable income in 2017 is equal to $31200. Entailment

% Facts
:- discontiguous s63_c_1/3.
:- discontiguous s151/5.
:- [law/semantics/init].
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
amount_(alice_is_paid,33200).
s63_c_1(alice,2017,2000).
s151(alice,0,_,_,2017).

% Test
:- s63_b(alice,2017,31200).
:- halt.

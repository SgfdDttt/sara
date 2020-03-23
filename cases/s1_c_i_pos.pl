% Text
% Alice's taxable income for the year 2017 is $7748. In 2017, Alice is not married, is not a surviving spouse, and is not a head of household.

% Question
% Alice has to pay $1162 in taxes for the year 2017 under section 1(c)(i). Entailment

% Facts
:- discontiguous s63/3.
:- [statutes/prolog/init].
s63(alice,2017,7748).

% Test
:- s1_c_i(7748,1162).
:- halt.

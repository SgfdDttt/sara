% Text
% Alice's taxable income for the year 2017 is $718791. Alice is not married, is not a surviving spouse, and is not a head of household in 2017.

% Question
% Alice has to pay $265413 in taxes for the year 2017 under section 1(c)(v). Entailment

% Facts
:- discontiguous s63/3.
:- [statutes/prolog/init].
s63(alice,2017,718791).

% Test
:- s1_c_v(718791,265413).
:- halt.

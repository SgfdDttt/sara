% Text
% Alice's taxable income for the year 2017 is $210204. In 2017, Alice is not married, is not a surviving spouse, and is not a head of household.

% Question
% Alice has to pay $65445 in taxes for the year 2017 under section 1(c)(iv). Entailment

% Facts
:- discontiguous s63/3.
:- [statutes/prolog/init].
s63(alice,2017,210204).

% Test
:- s1_c_iv(210204,65445).
:- halt.

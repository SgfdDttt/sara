% Text
% Alice's taxable income for the year 2017 is $102268. Alice is not married, is not a surviving spouse, and is not a head of household in 2017.

% Question
% Alice has to pay $27225 in taxes for the year 2017 under section 1(c)(iii). Entailment

% Facts
:- discontiguous s63/3.
:- [statutes/prolog/init].
s63(alice,2017,102268).

% Test
:- s1_c_iii(102268,27225).
:- halt.

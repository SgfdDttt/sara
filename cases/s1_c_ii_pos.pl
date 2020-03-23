% Text
% Alice's taxable income for the year 2017 is $22895. Alice is not married, is not a surviving spouse, and is not a head of household in 2017.

% Question
% Alice has to pay $3538 in taxes for the year 2017 under section 1(c)(ii). Entailment

% Facts
:- discontiguous s63/3.
:- [statutes/prolog/init].
s63(alice,2017,22895).

% Test
:- s1_c_ii(22895,3538).
:- halt.

% Text
% Alice is a surviving spouse for the year 2017. Alice's taxable income for the year 2017 is $25561.

% Question
% Alice has to pay $3834 in taxes for the year 2017 under section 1(a)(i). Entailment

% Facts
:- discontiguous s63/3.
:- discontiguous s2_a/5.
:- [statutes/prolog/init].
s2_a(alice,_,_,_,2017).
s63(alice,2017,25561).

% Test
:- s1_a_i(25561,3834).
:- halt.

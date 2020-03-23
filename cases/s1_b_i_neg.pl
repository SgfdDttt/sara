% Text
% Alice is a head of household for the year 2017. Alice's taxable income for the year 2017 is $1172980.

% Question
% Alice has to pay $442985 in taxes for the year 2017 under section 1(b)(i). Contradiction

% Facts
:- discontiguous s63/3.
:- discontiguous s2_b/4.
:- [law/semantics/init].
s2_b(alice,_,_,2017).
s63(alice,2017,1172980).

% Test
:- \+ s1_b_i(1172980,442985).
:- halt.

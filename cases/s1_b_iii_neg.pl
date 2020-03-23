% Text
% Alice is a head of household for the year 2017. Alice's taxable income for the year 2017 is $54775.

% Question
% Alice has to pay $11489 in taxes for the year 2017 under section 1(b)(iii). Contradiction

% Facts
:- discontiguous s63/3.
:- discontiguous s2_b/4.
:- [law/semantics/init].
s2_b(alice,_,_,2017).
s63(alice,2017,54775).

% Test
:- \+ s1_b_iii(54775,11489).
:- halt.

% Text
% Alice is a head of household for the year 2017. Alice's taxable income for the year 2017 is $194512.

% Question
% Alice has to pay $57509 in taxes for the year 2017 under section 1(b)(v). Contradiction

% Facts
:- discontiguous s63/3.
:- discontiguous s2_b/4.
:- [law/semantics/init].
s2_b(alice,_,_,2017).
s63(alice,2017,194512).

% Test
:- \+ s1_b_v(194512,57509).
:- halt.

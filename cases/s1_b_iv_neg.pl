% Text
% Alice is a head of household for the year 2017. Alice's taxable income for the year 2017 is $97407.

% Question
% Alice has to pay $24056 in taxes for the year 2017 under section 1(b)(iv). Contradiction

% Facts
:- discontiguous s63/3.
:- discontiguous s2_b/4.
:- [law/semantics/init].
s2_b(alice,_,_,2017).
s63(alice,2017,97407).

% Test
:- \+ s1_b_iv(97407,24056).
:- halt.

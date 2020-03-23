% Text
% Alice is a surviving spouse for the year 2017. Alice's taxable income for the year 2017 is $236422.

% Question
% Alice has to pay $70640 in taxes for the year 2017 under section 1(a)(iv). Entailment

% Facts
:- discontiguous s63/3.
:- discontiguous s2_a/5.
:- [law/semantics/init].
s2_a(alice,_,_,_,2017).
s63(alice,2017,236422).

% Test
:- s1_a_iv(236422,70640).
:- halt.

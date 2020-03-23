% Text
% Alice is a head of household for the year 2017. Alice's taxable income for the year 2017 is $9560.

% Question
% Alice has to pay $1434 in taxes for the year 2017 under section 1(b)(ii). Contradiction

% Facts
:- discontiguous s63/3.
:- discontiguous s2_b/4.
:- [statutes/prolog/init].
s2_b(alice,_,_,2017).
s63(alice,2017,9560).

% Test
:- \+ s1_b_ii(9560,1434).
:- halt.

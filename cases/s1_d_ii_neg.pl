% Text
% Alice is married under section 7703 for the year 2017. Alice's taxable income for the year 2017 is $113580. Alice files a separate return.

% Question
% Alice has to pay $33653 in taxes for the year 2017 under section 1(d)(ii). Contradiction

% Facts
:- discontiguous s7703/9.
:- discontiguous s63/3.
:- [statutes/prolog/init].
s7703(alice,spouse,_,_,_,_,_,_,2017).
s63(alice,2017,113580).

% Test
:- \+ s1_d_ii(113580,33653).
:- halt.

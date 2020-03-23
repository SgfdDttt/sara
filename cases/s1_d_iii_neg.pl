% Text
% Alice is married under section 7703 for the year 2017. Alice's taxable income for the year 2017 is $6662. Alice files a separate return.

% Question
% Alice has to pay $999 in taxes for the year 2017 under section 1(d)(iii). Contradiction

% Facts
:- discontiguous s7703/8.
:- discontiguous s63/3.
:- [law/semantics/init].
s7703(alice,spouse,_,_,_,_,_,2017).
s63(alice,2017,6662).

% Test
:- \+ s1_d_iii(6662,999).
:- halt.

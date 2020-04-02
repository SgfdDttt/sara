% Text
% Alice is married under section 7703 for the year 2017. Alice's taxable income for the year 2017 is $6662. Alice files taxes separately in 2017.

% Question
% Alice has to pay $999 in taxes for the year 2017 under section 1(d)(i). Entailment

% Facts
:- discontiguous s7703/9.
:- discontiguous s63/3.
:- [statutes/prolog/init].
s7703(alice,spouse,_,_,_,_,_,_,2017).
s63(alice,2017,6662).

% Test
:- s1_d_i(6662,999).
:- halt.

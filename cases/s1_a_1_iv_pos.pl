% Text
% Alice is married under section 7703 for the year 2017. Alice files a joint return with her spouse for 2017. Alice's and her spouse's taxable income for the year 2017 is $164612.

% Question
% Alice and her spouse have to pay $44789 in taxes for the year 2017 under section 1(a)(iv). Entailment

% Facts
:- discontiguous s63/3.
:- discontiguous s7703/8.
:- [law/semantics/init].
s7703(alice,spouse,_,_,_,_,_,2017).
joint_return_(joint_return).
agent_(joint_return,alice).
agent_(joint_return,spouse).
start_(joint_return,"2017-01-01").
end_(joint_return,"2017-12-31").
s63(alice,2017,164612).

% Test
:- s1_a_iv(164612,44789).
:- halt.

% Text
% Alice got married on Feb 29, 2000. Alice files a joint return with her spouse for 2017. Alice's gross income for the year 2017 is $22895, and her spouse's is $14257. They take the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $4073

% Facts
:- [statutes/prolog/init].
marriage_(alice_marriage).
agent_(alice_marriage,alice).
agent_(alice_marriage,spouse).
start_(alice_marriage,"2000-02-29").
joint_return_(joint_return).
agent_(joint_return,alice).
agent_(joint_return,spouse).
start_(joint_return,"2017-01-01").
end_(joint_return,"2017-12-31").
income_(alice_income_2017).
agent_(alice_income_2017,alice).
amount_(alice_income_2017,22895).
start_(alice_income_2017,"2017-12-31").
income_(spouse_income_2017).
agent_(spouse_income_2017,spouse).
amount_(spouse_income_2017,14257).
start_(spouse_income_2017,"2017-12-31").

% Test
:- tax(alice,2017,4073).
:- halt.

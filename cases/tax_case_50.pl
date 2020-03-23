% Text
% Alice got married on October 9th, 2016. Alice files a joint return with her spouse for 2017. Alice's and her spouse's gross income for the year 2017 is $42876. They take the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $4931

% Facts
:- [statutes/prolog/init].
marriage_(alice_marriage).
agent_(alice_marriage,alice).
agent_(alice_marriage,spouse).
start_(alice_marriage,"2016-10-09").
joint_return_(joint_return).
agent_(joint_return,alice).
agent_(joint_return,spouse).
start_(joint_return,"2017-01-01").
end_(joint_return,"2017-12-31").
income_(alice_income_2017).
agent_(alice_income_2017,alice).
start_(alice_income_2017,"2017-12-31").
amount_(alice_income_2017,42876).

% Test
:- tax(alice,2017,4931).
:- halt.

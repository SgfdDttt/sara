% Text
% Alice got married on Jan 6th, 2005. Alice files a joint return with her spouse for 2015. Alice's and her spouse's gross income for the year 2015 is $42876. Alice and her spouse take the standard deduction. Alice has a son, Bob, who has the same principal place of abode as her in 2015. Bob has a son, Charlie, who also has the same principal place of abode as his father in 2015.

% Question
% How much tax does Alice have to pay in 2015? $4331

% Facts
:- [statutes/prolog/init].
marriage_(alice_marriage).
agent_(alice_marriage,alice).
agent_(alice_marriage,spouse).
start_(alice_marriage,"2005-01-06").
joint_return_(joint_return).
agent_(joint_return,alice).
agent_(joint_return,spouse).
start_(joint_return,"2015-01-01").
end_(joint_return,"2015-12-31").
income_(alice_income_2015).
agent_(alice_income_2015,alice).
start_(alice_income_2015,"2015-12-31").
amount_(alice_income_2015,42876).
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,alice_house).
start_(alice_residence,"2015-01-01").
end_(alice_residence,"2015-12-31").
son_(bob_is_son).
agent_(bob_is_son,bob).
patient_(bob_is_son,alice).
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,alice_house).
start_(bob_residence,"2015-01-01").
end_(bob_residence,"2015-12-31").
son_(charlie_is_son).
agent_(charlie_is_son,charlie).
patient_(charlie_is_son,bob).
residence_(charlie_residence).
agent_(charlie_residence,charlie).
patient_(charlie_residence,alice_house).
start_(charlie_residence,"2015-01-01").
end_(charlie_residence,"2015-12-31").

% Test
:- tax(alice,2015,4331).
:- halt.

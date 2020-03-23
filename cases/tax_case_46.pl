% Text
% Alice has paid $3200 to Bob for work done from Feb 1st, 2020 to Sep 2nd, 2020 for agricultural labor. Alice paid Bob with eggs, grapes and hay. Alice has been married since 1999. Alice files a joint return with her spouse for 2020. Alice's and her spouse's gross income for the year 2020 is $103272. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2020? $17399

% Facts
:- [statutes/prolog/init].
service_(alice_employer).
patient_(alice_employer,alice).
agent_(alice_employer,bob).
start_(alice_employer,"2020-02-01").
end_(alice_employer,"2020-09-02").
purpose_(alice_employer,"agricultural labor").
payment_(alice_pays).
agent_(alice_pays,alice).
patient_(alice_pays,bob).
start_(alice_pays,"2020-09-02").
purpose_(alice_pays,alice_employer).
amount_(alice_pays,3200).
means_(alice_pays,"kind").
marriage_(alice_marriage).
agent_(alice_marriage,alice).
agent_(alice_marriage,spouse).
start_(alice_marriage,"1999-12-31").
joint_return_(joint_return).
agent_(joint_return,alice).
agent_(joint_return,spouse).
start_(joint_return,"2020-01-01").
end_(joint_return,"2020-12-31").
income_(alice_income_2020).
agent_(alice_income_2020,alice).
amount_(alice_income_2020,103272).
start_(alice_income_2020,"2020-12-31").

% Test
:- tax(alice,2020,17399).
:- halt.

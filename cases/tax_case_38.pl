% Text
% Alice got married on December 30th, 2017. Alice files a joint return with her spouse for 2017. Alice's and her spouse's gross income for the year 2017 is $684642. Alice has itemized deductions of $23029 for donating cash to a charity.

% Question
% How much tax does Alice have to pay in 2017? $243097

% Facts
:- [statutes/prolog/init].
marriage_(alice_marriage).
agent_(alice_marriage,alice).
agent_(alice_marriage,spouse).
start_(alice_marriage,"2017-12-30").
joint_return_(joint_return).
agent_(joint_return,alice).
agent_(joint_return,spouse).
start_(joint_return,"2017-01-01").
end_(joint_return,"2017-12-31").
income_(alice_income).
agent_(alice_income,alice).
amount_(alice_income,684642).
start_(alice_income,"2017-12-31").
deduction_(alice_deduction).
agent_(alice_deduction,alice).
amount_(alice_deduction,23029).
start_(alice_deduction,"2017-12-31").

% Test
:- tax(alice,2017,243097).
:- halt.

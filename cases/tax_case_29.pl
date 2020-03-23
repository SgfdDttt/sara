% Text
% Alice has been married since April 4th, 2015. Alice files a joint return with her spouse for 2016. Alice's and her spouse's gross income for the year 2016 is $164612. Alice has paid $4525 to Bob for work done in the year 2016. In 2016, Alice has also paid $9832 into a retirement fund for Bob, and $5322 into health insurance for Charlie, who is Alice's father and has retired in 2016. Charlie had no income in 2016. Alice and her spouse take the standard deduction.

% Question
% How much tax does Alice have to pay in 2016? $40741

% Facts
:- [statutes/prolog/init].
marriage_(alice_marriage).
agent_(alice_marriage,alice).
agent_(alice_marriage,spouse).
start_(alice_marriage,"2015-04-04").
joint_return_(joint_return).
agent_(joint_return,alice).
agent_(joint_return,spouse).
start_(joint_return,"2016-01-01").
end_(joint_return,"2016-12-31").
income_(alice_income).
agent_(alice_income,alice).
amount_(alice_income,164612).
start_(alice_income,"2016-12-31").
service_(alice_employer).
patient_(alice_employer,alice).
agent_(alice_employer,bob).
start_(alice_employer,"2016-01-01").
end_(alice_employer,"2016-12-31").
payment_(alice_pays_bob).
agent_(alice_pays_bob,alice).
patient_(alice_pays_bob,bob).
start_(alice_pays_bob,"2016-01-01").
end_(alice_pays_bob,"2016-12-31").
purpose_(alice_pays_bob,alice_employer).
amount_(alice_pays_bob,4525).
payment_(alice_pays_retirement).
agent_(alice_pays_retirement,alice).
patient_(alice_pays_retirement,retirement_fund).
purpose_(alice_pays_retirement,"make provisions for employees in case of retirement").
plan_(retirement_fund).
beneficiary_(alice_pays_retirement,bob).
start_(alice_pays_retirement,"2016-01-01").
end_(alice_pays_retirement,"2016-12-31").
amount_(alice_pays_retirement,9832).
payment_(alice_pays_insurance).
agent_(alice_pays_insurance,alice).
patient_(alice_pays_insurance,health_insurance_fund).
plan_(health_insurance_fund).
purpose_(alice_pays_insurance,"make provisions in case of sickness").
beneficiary_(alice_pays_insurance,charlie).
start_(alice_pays_insurance,"2016-01-01").
end_(alice_pays_insurance,"2016-12-31").
amount_(alice_pays_insurance,5322).
father_(alice_and_charlie).
agent_(alice_and_charlie,charlie).
patient_(alice_and_charlie,alice).
retirement_(charlie_retires).
agent_(charlie_retires,charlie).
start_(charlie_retires,"2016-01-01").

% Test
:- tax(alice,2016,40741).
:- halt.

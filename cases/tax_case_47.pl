% Text
% In 2017, Alice earned $133200. Bob's income in 2017 was $44311. Alice and Bob have been married since Feb 3rd, 2017. Alice has been blind since Feb 28, 2014. Alice has paid $4525 to Charlie for work done in the year 2017. In 2017, Alice has also paid $983 into a retirement fund for Charlie, and $5322 into health insurance for Charlie, both under a plan. Alice and Bob file jointly and take the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $45946

% Facts
:- [statutes/prolog/init].
income_(alice_income).
agent_(alice_income,alice).
start_(alice_income,"2017-12-31").
amount_(alice_income,133200).
income_(bob_income).
agent_(bob_income,bob).
start_(bob_income,"2017-12-31").
amount_(bob_income,44311).
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2017-02-03").
blindness_(alice_is_blind).
agent_(alice_is_blind,alice).
start_(alice_is_blind,"2014-02-28").
service_(alice_employer).
patient_(alice_employer,alice).
agent_(alice_employer,charlie).
start_(alice_employer,"2017-01-01").
end_(alice_employer,"2017-12-31").
payment_(alice_pays_charlie).
agent_(alice_pays_charlie,alice).
patient_(alice_pays_charlie,charlie).
start_(alice_pays_charlie,"2017-01-01").
end_(alice_pays_charlie,"2017-12-31").
purpose_(alice_pays_charlie,alice_employer).
amount_(alice_pays_charlie,4525).
payment_(alice_pays_retirement).
agent_(alice_pays_retirement,alice).
patient_(alice_pays_retirement,retirement_fund).
purpose_(alice_pays_retirement,alice_employer).
purpose_(retirement_fund,"make provisions for employees in case of retirement").
plan_(retirement_fund).
beneficiary_(retirement_fund,charlie).
start_(alice_pays_retirement,"2017-01-01").
end_(alice_pays_retirement,"2017-12-31").
amount_(alice_pays_retirement,983).
payment_(alice_pays_insurance).
agent_(alice_pays_insurance,alice).
patient_(alice_pays_insurance,health_insurance_fund).
purpose_(alice_pays_insurance,alice_employer).
plan_(health_insurance_fund).
purpose_(health_insurance_fund,"make provisions for employees in case of sickness").
beneficiary_(health_insurance_fund,charlie).
start_(alice_pays_insurance,"2017-01-01").
end_(alice_pays_insurance,"2017-12-31").
amount_(alice_pays_insurance,532).
joint_return_(alice_and_bob_joint_return).
agent_(alice_and_bob_joint_return,alice).
agent_(alice_and_bob_joint_return,bob).
start_(alice_and_bob_joint_return,"2017-01-01").
end_(alice_and_bob_joint_return,"2017-12-31").

% Test
:- tax(alice,2017,45946).
:- halt.

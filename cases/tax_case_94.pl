% Text
% Alice's gross income for the year 2010 is $210204. Alice has paid $45252 to Bob for work done in the year 2010. In 2010, Alice has also paid $9832 into a retirement fund for Bob, and $5322 into health insurance for Charlie, who is Alice's father and has retired in 2009. Bob has no income in 2010. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2010? $63345

% Facts
:- [statutes/prolog/init].
income_(alice_income_2010).
agent_(alice_income_2010,alice).
amount_(alice_income_2010,210204).
start_(alice_income_2010,"2010-12-31").
service_(alice_employer).
patient_(alice_employer,alice).
agent_(alice_employer,bob).
start_(alice_employer,"2010-01-01").
end_(alice_employer,"2010-12-31").
payment_(alice_pays_bob).
agent_(alice_pays_bob,alice).
patient_(alice_pays_bob,bob).
start_(alice_pays_bob,"2010-01-01").
end_(alice_pays_bob,"2010-12-31").
purpose_(alice_pays_bob,alice_employer).
amount_(alice_pays_bob,45252).
payment_(alice_pays_retirement).
agent_(alice_pays_retirement,alice).
patient_(alice_pays_retirement,retirement_fund).
purpose_(alice_pays_retirement,"make provisions for employees in case of retirement").
plan_(retirement_fund).
beneficiary_(alice_pays_retirement,bob).
start_(alice_pays_retirement,"2010-01-01").
end_(alice_pays_retirement,"2010-12-31").
amount_(alice_pays_retirement,9832).
payment_(alice_pays_insurance).
agent_(alice_pays_insurance,alice).
patient_(alice_pays_insurance,health_insurance_fund).
plan_(health_insurance_fund).
purpose_(alice_pays_insurance,"make provisions in case of sickness").
beneficiary_(alice_pays_insurance,charlie).
start_(alice_pays_insurance,"2010-01-01").
end_(alice_pays_insurance,"2010-12-31").
amount_(alice_pays_insurance,5322).
father_(alice_and_charlie).
agent_(alice_and_charlie,charlie).
patient_(alice_and_charlie,alice).
retirement_(charlie_retires).
agent_(charlie_retires,charlie).
start_(charlie_retires,"2009-01-01").

% Test
:- tax(alice,2010,63345).
:- halt.

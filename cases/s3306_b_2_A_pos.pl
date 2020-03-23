% Text
% Alice has paid $45252 to Bob for work done in the year 2017. In 2017, Alice has also paid $9832 into a retirement fund for Bob, and $5322 into health insurance for Bob.

% Question
% Section 3306(b)(2)(A) applies to the payment Alice made to the health insurance fund for the year 2017. Entailment

% Facts
:- [statutes/prolog/init].
service_(alice_employer).
patient_(alice_employer,alice).
agent_(alice_employer,bob).
start_(alice_employer,"2017-01-01").
end_(alice_employer,"2017-12-31").
payment_(alice_pays_bob).
agent_(alice_pays_bob,alice).
patient_(alice_pays_bob,bob).
start_(alice_pays_bob,"2017-01-01").
end_(alice_pays_bob,"2017-12-31").
purpose_(alice_pays_bob,alice_employer).
amount_(alice_pays_bob,45252).
payment_(alice_pays_retirement).
agent_(alice_pays_retirement,alice).
patient_(alice_pays_retirement,retirement_fund).
plan_(retirement_fund).
purpose_(retirement_fund,"make provisions for employees in case of retirement").
beneficiary_(retirement_fund,bob).
start_(alice_pays_retirement,"2017-01-01").
end_(alice_pays_retirement,"2017-12-31").
amount_(alice_pays_retirement,9832).
payment_(alice_pays_insurance).
agent_(alice_pays_insurance,alice).
patient_(alice_pays_insurance,health_insurance_fund).
plan_(health_insurance_fund).
purpose_(health_insurance_fund,"make provisions for employees in case of sickness").
beneficiary_(health_insurance_fund,bob).
start_(alice_pays_insurance,"2017-01-01").
end_(alice_pays_insurance,"2017-12-31").
amount_(alice_pays_insurance,5322).

% Test
:- s3306_b_2_A(health_insurance_fund).
:- halt.

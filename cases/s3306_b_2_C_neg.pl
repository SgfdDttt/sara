% Text
% Alice has paid $45252 to Bob for work done in the year 2017. In 2017, Alice has also paid $9832 into a retirement fund for Bob, and $5322 into life insurance for Charlie, who is Alice's father and has retired in 2016.

% Question
% Section 3306(b)(2)(C) applies to the payment Alice made to the retirement fund for the year 2017. Contradiction

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
purpose_(alice_pays_retirement,"make provisions for employees in case of retirement").
beneficiary_(alice_pays_retirement,bob).
start_(alice_pays_retirement,"2017-01-01").
end_(alice_pays_retirement,"2017-12-31").
amount_(alice_pays_retirement,9832).
payment_(alice_pays_insurance).
agent_(alice_pays_insurance,alice).
patient_(alice_pays_insurance,life_insurance_fund).
purpose_(alice_pays_insurance,"make provisions in case of death").
beneficiary_(alice_pays_insurance,charlie).
start_(alice_pays_insurance,"2017-01-01").
end_(alice_pays_insurance,"2017-12-31").
amount_(alice_pays_insurance,5322).
father_(alice_and_charlie).
agent_(alice_and_charlie,charlie).
patient_(alice_and_charlie,alice).
retirement_(charlie_retires).
agent_(charlie_retires,charlie).
start_(charlie_retires,"2016-01-01").

% Test
:- \+ s3306_b_2_C(retirement_fund).
:- halt.

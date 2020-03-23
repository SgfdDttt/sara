% Text
% In 2017, Alice's gross income was $310192. Since 2014, Alice maintains a house where she and her daughter lived. Alice was married since Jan 14th, 2010 until her husband died on Nov 23rd, 2016. In 2017, Alice is allowed itemized deductions of $17890. Alice has paid $45252 to Bob for work done in the year 2017. In 2017, Alice has also paid $9832 into a retirement fund for Bob, and $5322 into health insurance for Charlie, who is Alice's father and has retired in 2016. Charlie had no income in 2017.

% Question
% How much tax does Alice have to pay in 2017? $90683

% Facts
:- [statutes/prolog/init].
income_(alice_is_paid).
agent_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
amount_(alice_is_paid,310192).
payment_(alice_maintains_house).
agent_(alice_maintains_house,alice).
patient_(alice_maintains_house,alice_house).
amount_(alice_maintains_house,1).
purpose_(alice_maintains_house,alice_house).
start_(alice_maintains_house,Day) :- between(2014,2114,Year), first_day_year(Year,Day).
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,alice_house).
start_(alice_residence,"2014-01-01").
daughter_(daughter_of_alice).
agent_(daughter_of_alice,unnamed_daughter).
patient_(daughter_of_alice,alice).
residence_(daughter_residence).
agent_(daughter_residence,unnamed_daughter).
patient_(daughter_residence,alice_house).
start_(daughter_residence,"2014-01-01").
marriage_(alice_marriage).
agent_(alice_marriage,unnamed_husband).
agent_(alice_marriage,alice).
start_(alice_marriage,"2010-01-14").
death_(husband_death).
agent_(husband_death,unnamed_husband).
start_(husband_death,"2016-11-23").
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
plan_(retirement_fund).
beneficiary_(alice_pays_retirement,bob).
start_(alice_pays_retirement,"2017-01-01").
end_(alice_pays_retirement,"2017-12-31").
amount_(alice_pays_retirement,9832).
payment_(alice_pays_insurance).
agent_(alice_pays_insurance,alice).
patient_(alice_pays_insurance,health_insurance_fund).
plan_(health_insurance_fund).
purpose_(alice_pays_insurance,"make provisions in case of sickness").
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
deduction_(itemized_deductions).
agent_(itemized_deductions,alice).
amount_(itemized_deductions,17890).
start_(itemized_deductions,"2017-12-31").

% Test
:- tax(alice,2017,90683).
:- halt.

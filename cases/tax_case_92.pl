% Text
% Alice has paid $300 to Bob for work done from Feb 1st, 2010 to Sep 2nd, 2010, in Baltimore, Maryland, USA for domestic service in her home. In 2010, Alice was paid $33408. Alice is allowed itemized deductions of $680, $2102, $1993 and $4807.

% Question
% How much tax does Alice have to pay in 2010? $3274

% Facts
:- [law/semantics/init].
service_(alice_employer).
patient_(alice_employer,alice).
agent_(alice_employer,bob).
start_(alice_employer,"2010-02-01").
end_(alice_employer,"2010-09-02").
location_(alice_employer,baltimore).
location_(alice_employer,maryland).
location_(alice_employer,usa).
purpose_(alice_employer,"domestic service").
location_(alice_employer,"private home").
payment_(alice_pays).
agent_(alice_pays,alice).
patient_(alice_pays,bob).
start_(alice_pays,"2010-09-02").
purpose_(alice_pays,alice_employer).
amount_(alice_pays,300).
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2010-12-31").
amount_(alice_is_paid,33408).
deduction_(itemized_deduction_1).
agent_(itemized_deduction_1,alice).
start_(itemized_deduction_1,"2010-01-01").
amount_(itemized_deduction_1,680).
deduction_(itemized_deduction_2).
agent_(itemized_deduction_2,alice).
start_(itemized_deduction_2,"2010-01-01").
amount_(itemized_deduction_2,2102).
deduction_(itemized_deduction_3).
agent_(itemized_deduction_3,alice).
start_(itemized_deduction_3,"2010-01-01").
amount_(itemized_deduction_3,1993).
deduction_(itemized_deduction_4).
agent_(itemized_deduction_4,alice).
start_(itemized_deduction_4,"2010-01-01").
amount_(itemized_deduction_4,4807).

% Test
:- tax(alice,2010,3274).
:- halt.

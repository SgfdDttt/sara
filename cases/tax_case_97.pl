% Text
% Alice has paid $4512 to Bob for work done from Feb 1st, 2005 to Sep 2nd, 2005. In 2005, Alice was paid $133200. Alice is allowed itemized deductions of $2939 and $8744.

% Question
% How much tax does Alice have to pay in 2005? $33069

% Facts
:- [statutes/prolog/init].
service_(alice_employer).
patient_(alice_employer,alice).
agent_(alice_employer,bob).
start_(alice_employer,"2005-02-01").
end_(alice_employer,"2005-09-02").
payment_(alice_pays).
agent_(alice_pays,alice).
patient_(alice_pays,bob).
start_(alice_pays,"2005-09-02").
purpose_(alice_pays,alice_employer).
amount_(alice_pays,4512).
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2005-12-31").
amount_(alice_is_paid,133200).
deduction_(itemized_deduction_1).
agent_(itemized_deduction_1,alice).
amount_(itemized_deduction_1,2939).
start_(itemized_deduction_1,"2005-01-01").
deduction_(itemized_deduction_2).
agent_(itemized_deduction_2,alice).
amount_(itemized_deduction_2,8744).
start_(itemized_deduction_2,"2005-01-01").

% Test
:- tax(alice,2005,33069).
:- halt.

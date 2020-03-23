% Text
% Alice's gross income in 2015 is $395276. Alice is allowed itemized deductions of $4571, $1973 and $15271.

% Question
% How much tax does Alice have to pay in 2015? $130388

% Facts
:- [statutes/prolog/init].
income_(alice_makes_money).
agent_(alice_makes_money,alice).
amount_(alice_makes_money,395276).
start_(alice_makes_money,"2015-01-01").
end_(alice_makes_money,"2015-12-31").
deduction_(itemized_deduction_1).
agent_(itemized_deduction_1,alice).
amount_(itemized_deduction_1,4571).
start_(itemized_deduction_1,"2015-12-31").
deduction_(itemized_deduction_2).
agent_(itemized_deduction_2,alice).
amount_(itemized_deduction_2,1973).
start_(itemized_deduction_2,"2015-12-31").
deduction_(itemized_deduction_3).
agent_(itemized_deduction_3,alice).
amount_(itemized_deduction_3,15271).
start_(itemized_deduction_3,"2015-12-31").

% Test
:- tax(alice,2015,130388).
:- halt.

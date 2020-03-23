% Text
% Alice married Bob on August 25th, 2011. Alice files a joint return with her husband for 2017. Alice's and Bob's gross income for the year 2017 is $22895 and they take the standard deduction. Alice is 67 years old in 2017.

% Question
% How much tax does Alice have to pay in 2017? $1844

% Facts
:- [statutes/prolog/init].
marriage_(alice_marriage).
agent_(alice_marriage,alice).
agent_(alice_marriage,bob).
start_(alice_marriage,"2011-08-25").
joint_return_(joint_return).
agent_(joint_return,alice).
agent_(joint_return,bob).
start_(joint_return,"2017-01-01").
end_(joint_return,"2017-12-31").
income_(alice_income_2017).
agent_(alice_income_2017,alice).
amount_(alice_income_2017,22895).
start_(alice_income_2017,"2017-12-31").
birth_(alice_is_born).
agent_(alice_is_born,alice).
start_(alice_is_born,"1950-01-01").

% Test
:- tax(alice,2017,1844).
:- halt.

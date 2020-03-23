% Text
% Alice and Bob have been married since Feb 3rd, 2017. Alice was born March 2nd, 1950 and Bob was born March 3rd, 1955. Bob's gross income for the year 2019 is $113580. Alice and Bob file jointly in 2019, and take the standard deduction. Alice had no income in 2019.

% Question
% How much tax does Bob have to pay in 2019? $20298

% Facts
:- [statutes/prolog/init].
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
amount_(alice_is_paid,33200).
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2017-02-03").
birth_(alice_is_born).
agent_(alice_is_born,alice).
start_(alice_is_born,"1950-03-02").
end_(alice_is_born,"1950-03-02").
birth_(bob_is_born).
agent_(bob_is_born,bob).
start_(bob_is_born,"1955-03-03").
end_(bob_is_born,"1955-03-03").
income_(bob_income_2019).
agent_(bob_income_2019,bob).
amount_(bob_income_2019,113580).
start_(bob_income_2019,"2019-12-31").
joint_return_(joint_return).
agent_(joint_return,alice).
agent_(joint_return,bob).
start_(joint_return,"2019-01-01").
end_(joint_return,"2019-12-31").

% Test
:- tax(bob,2019,20298).
:- halt.

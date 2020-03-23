% Text
% Alice and Bob have been married since Feb 3rd, 2017. Alice files a joint return with her spouse for 2020. Alice's gross income for the year 2020 is $103272. Bob earned $10 in 2020. Alice and Bob take the standard deduction.

% Question
% How much tax does Bob have to pay in 2020? $17402

% Facts
:- [statutes/prolog/init].
joint_return_(joint_return).
agent_(joint_return,alice).
agent_(joint_return,bob).
start_(joint_return,"2020-01-01").
end_(joint_return,"2020-12-31").
income_(alice_income_2020).
agent_(alice_income_2020,alice).
start_(alice_income_2020,"2020-12-31").
amount_(alice_income_2020,103272).
payment_(bob_is_paid).
patient_(bob_is_paid,bob).
start_(bob_is_paid,"2020-12-31").
amount_(bob_is_paid,10).
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2017-02-03").

% Test
:- tax(bob,2020,17402).
:- halt.

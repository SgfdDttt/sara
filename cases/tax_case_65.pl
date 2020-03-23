% Text
% In 2016, Alice was paid $51020 in remuneration. Alice and Bob have been married since Feb 3rd, 2016, and they file a joint return for 2016. Bob's gross income in 2016 was $42939. Alice and Bob take itemized deductions of $21137.

% Question
% How much tax does Alice have to pay in 2016? $14473

% Facts
:- [statutes/prolog/init].
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2016-12-31").
amount_(alice_is_paid,51020).
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2016-02-03").
joint_return_(alice_and_bob_file_a_joint_return).
agent_(alice_and_bob_file_a_joint_return,alice).
agent_(alice_and_bob_file_a_joint_return,bob).
start_(alice_and_bob_file_a_joint_return,"2016-01-01").
end_(alice_and_bob_file_a_joint_return,"2016-12-31").
income_(bob_income).
agent_(bob_income,bob).
amount_(bob_income,42939).
start_(bob_income,"2016-12-31").
deduction_(itemized_deduction).
agent_(itemized_deduction,alice).
amount_(itemized_deduction,21137).
start_(itemized_deduction,"2016-12-31").

% Test
:- tax(alice,2016,14473).
:- halt.

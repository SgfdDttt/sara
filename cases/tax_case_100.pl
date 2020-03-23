% Text
% Alice's gross income for the year 2006 is $97407. Bob's gross income for the year 2006 is $136370. Alice and Bob have been married since Feb 3rd, 2006. Bob and Alice file a joint return for 2006 and take the standard deduction.

% Question
% How much tax does Bob have to pay in 2006? $66088

% Facts
:- [statutes/prolog/init].
income_(alice_income_2006).
agent_(alice_income_2006,alice).
amount_(alice_income_2006,97407).
start_(alice_income_2006,"2006-12-31").
income_(bob_income_2006).
agent_(bob_income_2006,bob).
amount_(bob_income_2006,136370).
start_(bob_income_2006,"2006-12-31").
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2006-02-03").
joint_return_(bob_and_alice_joint_return).
agent_(bob_and_alice_joint_return,bob).
agent_(bob_and_alice_joint_return,alice).
start_(bob_and_alice_joint_return,"2006-01-01").
end_(bob_and_alice_joint_return,"2006-12-31").

% Test
:- tax(alice,2006,66088).
:- halt.

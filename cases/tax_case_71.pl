% Text
% In 2017, Alice was paid $433320 in remuneration. Alice and Bob got married on Jan 1st, 2015. Bob's gross income for 2017 is $532134. Alice and Bob file a joint return for the year 2017 and take the standard deduction.

% Question
% How much tax does Alice have to pay in 356472? $356472

% Facts
:- [statutes/prolog/init].
payment_(alice_income).
patient_(alice_income,alice).
start_(alice_income,"2017-12-31").
amount_(alice_income,433320).
income_(bob_income_2017).
agent_(bob_income_2017,bob).
start_(bob_income_2017,"2017-12-31").
amount_(bob_income_2017,532134).
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2015-01-01").
joint_return_(alice_and_bob_joint_return).
agent_(alice_and_bob_joint_return,alice).
agent_(alice_and_bob_joint_return,bob).
start_(alice_and_bob_joint_return,"2017-01-01").
end_(alice_and_bob_joint_return,"2017-12-31").

% Test
:- tax(alice,2017,356472).
:- halt.

% Text
% Alice's income for the year 2003 is $54313. Alice and Bob have been married since Feb 3rd, 1985. Bob had no income in 2003. Bob and Alice file a joint return for 2003 and take the standard deduction.

% Question
% How much tax does Alice have to pay in 2003? $7611

% Facts
:- [statutes/prolog/init].
income_(alice_income_2003).
agent_(alice_income_2003,alice).
start_(alice_income_2003,"2003-12-31").
amount_(alice_income_2003,54313).
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"1985-02-03").
joint_return_(bob_and_alice_joint_return).
agent_(bob_and_alice_joint_return,bob).
agent_(bob_and_alice_joint_return,alice).
start_(bob_and_alice_joint_return,"2003-01-01").
end_(bob_and_alice_joint_return,"2003-12-31").

% Test
:- tax(alice,2003,7611).
:- halt.

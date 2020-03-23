% Text
% Alice and Bob got married on Feb 3rd, 1992. Alice died on July 9th, 2014. In 2014, Alice's gross income was $55431 and Bob's gross income was $64314. Bob files a joint return for himself and Alice for 2014. Bob takes the standard deduction.

% Question
% How much tax does Bob have to pay in 2014? $26549

% Facts
:- [statutes/prolog/init].
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"1992-02-03").
death_(alice_dies).
agent_(alice_dies,alice).
start_(alice_dies,"2014-07-09").
income_(alice_income).
agent_(alice_income,alice).
amount_(alice_income,55431).
start_(alice_income,"2014-12-31").
income_(bob_income).
agent_(bob_income,bob).
amount_(bob_income,64314).
start_(bob_income,"2014-12-31").
joint_return_(alice_and_bob_joint_return).
agent_(alice_and_bob_joint_return,bob).
agent_(alice_and_bob_joint_return,alice).
start_(alice_and_bob_joint_return,"2014-01-01").
end_(alice_and_bob_joint_return,"2014-12-31").

% Test
:- tax(bob,2014,26549).
:- halt.

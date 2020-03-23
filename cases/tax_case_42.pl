% Text
% Alice and Bob got married on Feb 3rd, 1992. Alice was a nonresident alien. Alice died on July 9th, 2014. Bob married Charlie on September 14th, 2015. Bob's gross income for the year 2015 is $28864, Charlie's gross income is $27953. Bob and Charlie file jointly in 2015 and take the standard deduction.

% Question
% How much tax does Bob have to pay in 2015? $8312

% Facts
:- [statutes/prolog/init].
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"1992-02-03").
nonresident_alien_(alice_is_nra).
agent_(alice_is_nra,alice).
death_(alice_dies).
agent_(alice_dies,alice).
start_(alice_dies,"2014-07-09").
end_(alice_dies,"2014-07-09").
marriage_(bob_and_charlie).
agent_(bob_and_charlie,charlie).
agent_(bob_and_charlie,bob).
start_(bob_and_charlie,"2015-09-14").
income_(bob_income).
agent_(bob_income,bob).
start_(bob_income,"2015-12-31").
amount_(bob_income,28864).
income_(charlie_income).
agent_(charlie_income,charlie).
start_(charlie_income,"2015-12-31").
amount_(charlie_income,27953).
joint_return_(bob_and_charlie_joint_return).
agent_(bob_and_charlie_joint_return,bob).
agent_(bob_and_charlie_joint_return,charlie).
start_(bob_and_charlie_joint_return,"2015-01-01").
end_(bob_and_charlie_joint_return,"2015-12-31").

% Test
:- tax(bob,2015,8312).
:- halt.

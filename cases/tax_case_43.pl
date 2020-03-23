% Text
% In 2017, Alice was paid $23191. Alice and Bob got married on Feb 3rd, 1992. Alice was a nonresident alien until July 9th, 2014. Bob earned $34081 in 2017. Alice and Bob file jointly in 2017 and take the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $8439

% Facts
:- [statutes/prolog/init].
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
amount_(alice_is_paid,23191).
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"1992-02-03").
nonresident_alien_(alice_is_a_nra).
agent_(alice_is_a_nra,alice).
end_(alice_is_a_nra,"2014-07-09").
income_(bob_income).
agent_(bob_income,bob).
amount_(bob_income,34081).
start_(bob_income,"2017-12-31").
joint_return_(alice_and_bob_joint_return).
agent_(alice_and_bob_joint_return,alice).
agent_(alice_and_bob_joint_return,bob).
start_(alice_and_bob_joint_return,"2017-01-01").
end_(alice_and_bob_joint_return,"2017-12-31").

% Test
:- tax(alice,2017,8439).
:- halt.

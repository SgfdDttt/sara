% Text
% Alice has a brother, Bob, who was born January 31st, 2014. Alice's gross income in 2020 was $604312. Alice married Charlie on October 12th, 1992. Charlie had no income in 2020. Alice and Charlie file jointly and take the standard deduction.

% Question
% How much tax does Alice have to pay in 2020? $206332

% Facts
:- [statutes/prolog/init].
brother_(alice_and_bob).
agent_(alice_and_bob,bob).
patient_(alice_and_bob,alice).
start_(alice_and_bob,"2014-01-31").
income_(alice_income_2020).
agent_(alice_income_2020,alice).
amount_(alice_income_2020,604312).
start_(alice_income_2020,"2020-12-31").
marriage_(alice_and_charlie).
agent_(alice_and_charlie,alice).
agent_(alice_and_charlie,charlie).
start_(alice_and_charlie,"1992-10-12").
joint_return_(joint_return).
agent_(joint_return,alice).
agent_(joint_return,charlie).
start_(joint_return,"2020-01-01").
end_(joint_return,"2020-12-31").

% Test
:- tax(alice,2020,206332).
:- halt.

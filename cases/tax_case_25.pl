% Text
% Bob is Charlie and Dorothy's son, born on April 15th, 2015. Alice married Charlie on August 8th, 2018. Alice and Charlie's gross income in 2018 were $324311 and $414231 respectively. Alice, Bob and Charlie have the same principal place of abode in 2018. Alice and Charlie file jointly in 2018, and take the standard deduction.

% Question
% How much tax does Alice have to pay in 2018? $259487

% Facts
:- [statutes/prolog/init].
son_(bob_birth).
agent_(bob_birth,bob).
patient(bob_birth,charlie).
patient(bob_birth,dorothy).
start_(bob_birth,"2015-04-15").
marriage_(alice_and_charlie).
agent_(alice_and_charlie,alice).
agent_(alice_and_charlie,charlie).
start_(alice_and_charlie,"2018-08-08").
income_(alice_income).
agent_(alice_income,alice).
amount_(alice_income,324311).
start_(alice_income,"2018-12-31").
income_(charlie_income).
agent_(charlie_income,charlie).
amount_(charlie_income,414231).
start_(charlie_income,"2018-12-31").
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,abc_home).
start_(alice_residence,"2018-01-01").
end_(alice_residence,"2018-12-31").
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,abc_home).
start_(bob_residence,"2018-01-01").
end_(bob_residence,"2018-12-31").
residence_(charlie_residence).
agent_(charlie_residence,charlie).
patient_(charlie_residence,abc_home).
start_(charlie_residence,"2018-01-01").
end_(charlie_residence,"2018-12-31").
joint_return_(alice_and_charlie_joint_return).
agent_(alice_and_charlie_joint_return,alice).
agent_(alice_and_charlie_joint_return,charlie).
start_(alice_and_charlie_joint_return,"2018-01-01").
end_(alice_and_charlie_joint_return,"2018-12-31").

% Test
:- tax(alice,2018,259487).
:- halt.

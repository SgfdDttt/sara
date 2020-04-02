% Text
% In 2017, Alice was paid $33200. Bob is Alice's father since April 15th, 1978. In 2017, Alice and Bob lived in a house that Alice maintained. In 2017, Alice takes the standard deduction. Bob had no income in 2017.

% Question
% How much tax does Alice have to pay in 2017? $3720

% Facts
:- [statutes/prolog/init].
payment_(alice_income).
patient_(alice_income,alice).
start_(alice_income,"2017-12-31").
amount_(alice_income,33200).
father_(alice_and_bob).
agent_(alice_and_bob,bob).
patient_(alice_and_bob,alice).
start_(alice_and_bob,"1978-04-15").
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,alice_house).
start_(alice_residence,"2017-01-01").
end_(alice_residence,"2017-12-31").
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,alice_house).
start_(bob_residence,"2017-01-01").
end_(bob_residence,"2017-12-31").
payment_(home_maintenance).
agent_(home_maintenance,alice).
amount_(home_maintenance,1).
purpose_(home_maintenance,alice_house).
start_(home_maintenance,"2017-12-31").

% Test
:- tax(alice,2017,3720).
:- halt.

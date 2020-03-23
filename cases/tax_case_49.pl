% Text
% Bob is Alice and Charlie's father. Bob had no income in 2015. Alice's gross income in 2015 is $264215. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2015? $82819

% Facts
:- [statutes/prolog/init].
father_(bob_is_father).
agent_(bob_is_father,bob).
patient_(bob_is_father,alice).
patient_(bob_is_father,charlie).
income_(alice_income_2015).
agent_(alice_income_2015,alice).
amount_(alice_income_2015,264215).
start_(alice_income_2015,"2015-12-31").

% Test
:- tax(alice,2015,82819).
:- halt.

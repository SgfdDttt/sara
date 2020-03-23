% Text
% Charlie is Alice's father since April 15th, 1994. Bob is Charlie's brother since October 12th, 1992. Alice's gross income in 2015 is $87319. Both Charlie and Bob have no income in 2015, and are not qualifying children to any taxpayer.

% Question
% How much tax does Alice have to pay in 2015? $19801

% Facts
:- [statutes/prolog/init].
father_(alice_and_bob).
agent_(alice_and_bob,bob).
patient_(alice_and_bob,alice).
start_(alice_and_bob,"1994-04-15").
brother_(bob_and_charlie).
agent_(bob_and_charlie,bob).
patient_(bob_and_charlie,charlie).
start_(bob_and_charlie,"1992-10-12").
income_(alice_income_2015).
agent_(alice_income_2015,alice).
start_(alice_income_2015,"2015-12-31").
amount_(alice_income_2015,87319).

% Test
:- tax(alice,2015,19801).
:- halt.

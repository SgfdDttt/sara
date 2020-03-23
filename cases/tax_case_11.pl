% Text
% Charlie is Bob's father since April 15th, 2014, and Bob has lived at Charlie's place since then. Alice is Charlie's sister since October 12th, 1992. Charlie's gross income in 2015 was $52650. In 2015, Alice's gross income was $2312. Alice takes the standard deduction in 2015.

% Question
% How much tax does Alice have to pay in 2015? $0

% Facts
:- [statutes/prolog/init].
father_(charlie_and_bob).
agent_(charlie_and_bob,charlie).
patient_(charlie_and_bob,bob).
start_(charlie_and_bob,"2014-04-15").
residence_(charlie_residence).
agent_(charlie_residence,charlie).
patient_(charlie_residence,charlie_home).
start_(charlie_residence,"2014-01-01").
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,charlie_home).
start_(bob_residence,"2014-04-15").
sister_(alice_and_charlie).
agent_(alice_and_charlie,alice).
patient_(alice_and_charlie,charlie).
start_(alice_and_charlie,"1992-10-12").
income_(charlie_income).
agent_(charlie_income,charie).
amount_(charlie_income,52650).
start_(charlie_income,"2015-01-01").
end_(charlie_income,"2015-12-31").
income_(alice_makes_money).
agent_(alice_makes_money,alice).
amount_(alice_makes_money,2312).
start_(alice_makes_money,"2015-01-01").
end_(alice_makes_money,"2015-12-31").

% Test
:- tax(alice,2015,0).
:- halt.

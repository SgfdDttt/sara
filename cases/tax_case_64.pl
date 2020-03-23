% Text
% Alice has a brother, Bob, who was born January 31st, 2014. Alice's gross income in 2015 was $260932. Bob lived at Alice's house in 2015. For 2015, Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2015? $81487

% Facts
:- [statutes/prolog/init].
brother_(alice_and_bob).
agent_(alice_and_bob,bob).
patient_(alice_and_bob,alice).
start_(alice_and_bob,"2014-01-31").
income_(alice_makes_money).
agent_(alice_makes_money,alice).
amount_(alice_makes_money,260932).
start_(alice_makes_money,"2015-01-01").
end_(alice_makes_money,"2015-12-31").
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,alice_house).
start_(alice_residence,"2015-01-01").
end_(alice_residence,"2015-12-31").
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,alice_house).
start_(bob_residence,"2015-01-01").
end_(bob_residence,"2015-12-31").

% Test
:- tax(alice,2015,81487).
:- halt.

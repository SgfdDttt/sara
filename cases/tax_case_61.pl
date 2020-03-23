% Text
% Bob, Alice's father, has the same principal place of abode as Alice since 2012, and has had no income since. Alice's gross income for the year 2015 is $102268. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2015? $25055

% Facts
:- [statutes/prolog/init].
father_(bob_is_father).
agent_(bob_is_father,bob).
patient_(bob_is_father,alice).
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,home).
start_(alice_residence,"2012-01-01").
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,home).
start_(bob_residence,"2012-01-01").
income_(alice_makes_money).
agent_(alice_makes_money,alice).
amount_(alice_makes_money,102268).
start_(alice_makes_money,"2015-01-01").
end_(alice_makes_money,"2015-12-31").

% Test
:- tax(alice,2015,25055).
:- halt.

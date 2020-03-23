% Text
% Alice's income in 2015 is $100000. She gets one exemption of $2000 for the year 2015 under section 151(c). Alice is not married.

% Question
% Alice's total exemption for 2015 under section 151(a) is equal to $6000. Contradiction

% Facts
:- discontiguous s151_c/4.
:- [statutes/prolog/init].
income_(alice_makes_money).
agent_(alice_makes_money,alice).
start_(alice_makes_money,"2015-01-01").
end_(alice_makes_money,"2015-12-31").
amount_(alice_makes_money,100000).
s151_c(alice,_,2000,2015).

% Test
:- \+ s151_a(alice,6000,2015).
:- halt.

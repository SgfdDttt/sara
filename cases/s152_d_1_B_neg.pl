% Text
% In 2015, Alice's income was $2312. The exemption amount for Alice under section 151(d) for the year 2015 was $2000.

% Question
% Section 152(d)(1)(B) applies to Alice for the year 2015. Contradiction

% Facts
:- discontiguous s151_d/4.
:- [statutes/prolog/init].
income_(alice_makes_money).
agent_(alice_makes_money,alice).
amount_(alice_makes_money,2312).
start_(alice_makes_money,"2015-01-01").
end_(alice_makes_money,"2015-12-31").
s151_d(alice,_,2000,2015).

% Test
:- \+ s152_d_1_B(alice,2015).
:- halt.

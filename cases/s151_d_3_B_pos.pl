% Text
% Alice's income in 2015 is $276932. Alice is not married. The applicable amount according to section 68(b) is $250000.

% Question
% Under section 151(d)(3)(B), the applicable percentage for Alice for 2015 is equal to 22. Entailment

% Facts
:- discontiguous s68_b/3.
:- [statutes/prolog/init].
income_(alice_makes_money).
agent_(alice_makes_money,alice).
amount_(alice_makes_money,276932).
start_(alice_makes_money,"2015-01-01").
end_(alice_makes_money,"2015-12-31").
s68_b(alice,2015,250000).

% Test
:- s151_d_3_B(22,alice,_,2015,_).
:- halt.

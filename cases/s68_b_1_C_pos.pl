% Text
% In 2016, Alice's income was $567192. Alice is not married, is not a surviving spouse, and is not a head of household in 2016.

% Question
% Section 68(b)(1)(C) applies to Alice in 2016 with the applicable amount equal to $250000. Entailment

% Facts
:- [statutes/prolog/init].
income_(alice_is_paid).
agent_(alice_is_paid,alice).
start_(alice_is_paid,"2016-12-31").
amount_(alice_is_paid,567192).

% Test
:- s68_b_1_C(alice,250000,2016).
:- halt.

% Text
% In 2016, Alice's income was $567192. Alice is a head of household for the year 2016.

% Question
% Under section 68(b)(1)(B), Alice's applicable amount for 2016 is equal to $275000. Entailment

% Facts
:- discontiguous s2_b/4.
:- [law/semantics/init].
income_(alice_is_paid).
agent_(alice_is_paid,alice).
start_(alice_is_paid,"2016-12-31").
amount_(alice_is_paid,567192).
s2_b(alice,_,_,2016).

% Test
:- s68_b_1_B(alice,275000,2016).
:- halt.

% Text
% In 2016, Alice's income was $567192. Alice is a surviving spouse for the year 2016.

% Question
% Under section 68(b)(1)(A), Alice's applicable amount for 2016 is equal to $300000. Entailment

% Facts
:- discontiguous s2_a/5.
:- [law/semantics/init].
income_(alice_is_paid).
agent_(alice_is_paid,alice).
start_(alice_is_paid,"2016-12-31").
amount_(alice_is_paid,567192).
s2_a(alice,_,_,_,2016).

% Test
:- s68_b_1_A(alice,300000,2016).
:- halt.

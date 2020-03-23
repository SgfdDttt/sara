% Text
% In 2014, Alice's income was $310192. Alice is a surviving spouse for the year 2014. Alice is allowed itemized deductions of $600 under section 63.

% Question
% Section 68(f) applies to Alice for the year 2014. Contradiction

% Facts
:- discontiguous s2_a/5.
:- [statutes/prolog/init].
income_(alice_is_paid).
agent_(alice_is_paid,alice).
start_(alice_is_paid,"2014-12-31").
amount_(alice_is_paid,310192).
s2_a(alice,_,_,_,2014).

% Test
:- \+ s68_f(2014).
:- halt.

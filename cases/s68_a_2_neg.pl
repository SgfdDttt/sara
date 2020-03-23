% Text
% In 2016, Alice's income was $295192. Alice is a surviving spouse for the year 2016. Alice is allowed itemized deductions of $60000 under section 63.

% Question
% Section 68(a)(2) prescribes a reduction of Alice's itemized deductions for the year 2016 by $47000. Contradiction

% Facts
:- discontiguous s2_a/5.
:- [statutes/prolog/init].
income_(alice_is_paid).
agent_(alice_is_paid,alice).
start_(alice_is_paid,"2016-12-31").
amount_(alice_is_paid,295192).
s2_a(alice,_,_,_,2016).

% Test
:- \+ s68_a_2(60000,47000).
:- halt.

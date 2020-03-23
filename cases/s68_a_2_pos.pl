% Text
% In 2016, Alice's income was $277192. Alice is a head of household for the year 2016. Alice is allowed itemized deductions of $60000 under section 63.

% Question
% Section 68(a)(2) prescribes a reduction of Alice's itemized deductions for the year 2016 by $48000. Entailment

% Facts
:- discontiguous s2_b/4.
:- [law/semantics/init].
income_(alice_is_paid).
agent_(alice_is_paid,alice).
start_(alice_is_paid,"2016-12-31").
amount_(alice_is_paid,277192).
s2_b(alice,_,_,2016).

% Test
:- s68_a_2(60000,48000).
:- halt.

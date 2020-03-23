% Text
% In 2015, Alice did not have any income. The exemption amount for Alice under section 151(d) for the year 2015 was $2000.

% Question
% Section 152(d)(1)(B) applies to Alice for the year 2015. Entailment

% Facts
:- discontiguous s151_d/4.
:- [statutes/prolog/init].
s151_d(alice,_,2000,2015).

% Test
:- s152_d_1_B(alice,2015).
:- halt.

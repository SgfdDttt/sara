% Text
% Alice is entitled to an exemption for herself under section 151(b) for the year 2015. No other taxpayer is entitled to a deduction for Alice in 2015.

% Question
% Alice's exemption amount under section 151(d)(1) is equal to $2000. Entailment

% Facts
:- discontiguous s151_b_applies/2.
:- [statutes/prolog/init].
s151_b_applies(alice,2015).

% Test
:- s151_d_1(2000).
:- halt.

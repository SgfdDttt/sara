% Text
% Alice is entitled to an exemption under section 151(b) for the year 2018.

% Question
% The exemption amount of Alice's exemption is equal to $2000 under section 151(d)(5)(A). Contradiction

% Facts
:- discontiguous s151_b_applies/2.
:- [statutes/prolog/init].
s151_b_applies(alice,2018).

% Test
:- \+ s151_d_5(2000,2018).
:- halt.

% Text
% Alice is entitled to an exemption under section 151(c) for Bob for the year 2015.

% Question
% Under section 151(d)(2), Bob's exemption amount for the year 2015 is equal to $0. Entailment

% Facts
:- discontiguous s151_c_applies/3.
:- [law/semantics/init].
s151_c_applies(alice,bob,2015).

% Test
:- s151_d_2(_,bob,_,0,2015).
:- halt.

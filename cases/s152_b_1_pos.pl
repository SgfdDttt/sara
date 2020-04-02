% Text
% Alice has a son, Bob, who satisfies section 152(c)(1) for the year 2015. Bob has a son, Charlie, who satisfies section 152(c)(1) for the year 2015.

% Question
% Section 152(b)(1) applies to Bob for the year 2015. Entailment

% Facts
:- discontiguous s152_c_1/3.
:- [statutes/prolog/init].
s152_c_1(bob,alice,2015).
s152_c_1(charlie,bob,2015).

% Test
:- s152_b_1(bob,_,2015).
:- halt.

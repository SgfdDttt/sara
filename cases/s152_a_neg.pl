% Text
% Alice has a son, Bob, who satisfies section 152(c)(1) for the year 2015.

% Question
% Under section 152(a), Bob is a dependent of Alice for the year 2014. Contradiction

% Facts
:- discontiguous s152_c_1/5.
:- [law/semantics/init].
s152_c_1(bob,alice,2015,_,_).

% Test
:- \+ s152_a(bob,alice,2014,_,_,_,_).
:- halt.

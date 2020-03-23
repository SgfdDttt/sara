% Text
% Alice has a son, Bob, who was born January 31st, 2014.

% Question
% Alice bears a relationship to Bob under section 152(c)(2). Contradiction

% Facts
:- [statutes/prolog/init].
son_(alice_and_bob).
agent_(alice_and_bob,bob).
patient_(alice_and_bob,alice).
start_(alice_and_bob,"2014-01-31").

% Test
:- \+ s152_c_2(alice,bob,_,_).
:- halt.

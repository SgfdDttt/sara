% Text
% Alice has a son, Bob, who was born January 31st, 2014.

% Question
% Bob bears a relationship to Alice under section 152(c)(2)(A). Entailment

% Facts
:- [statutes/prolog/init].
son_(alice_and_bob).
agent_(alice_and_bob,bob).
patient_(alice_and_bob,alice).
start_(alice_and_bob,"2014-01-31").

% Test
:- s152_c_2_A(bob,alice,_,_,_).
:- halt.

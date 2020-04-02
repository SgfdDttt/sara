% Text
% Bob is Alice's father since April 15th, 1994. In 2015, Alice and Bob live in separate houses.

% Question
% Alice bears a relationship to Bob under section 152(d)(2)(H) for the year 2015. Contradiction

% Facts
:- [statutes/prolog/init].
father_(alice_and_bob).
agent_(alice_and_bob,bob).
patient_(alice_and_bob,alice).
start_(alice_and_bob,"1994-04-15").

% Test
:- \+ s152_d_2_H(alice,bob,2015,_,_,_).
:- halt.

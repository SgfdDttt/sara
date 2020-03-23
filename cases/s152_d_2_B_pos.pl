% Text
% Bob is Alice's brother since April 15th, 2014.

% Question
% Alice bears a relationship to Bob under section 152(d)(2)(B) for the year 2015. Entailment

% Facts
:- [statutes/prolog/init].
brother_(alice_and_bob).
agent_(alice_and_bob,bob).
patient_(alice_and_bob,alice).
start_(alice_and_bob,"2014-04-15").

% Test
:- s152_d_2_B(alice,bob,_,_).
:- halt.

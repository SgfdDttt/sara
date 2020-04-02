% Text
% Alice and Bob started living together on April 15th, 2014. Alice and Bob are not married.

% Question
% Alice bears a relationship to Bob under section 152(d)(2)(H) for the year 2018. Entailment

% Facts
:- [statutes/prolog/init].
residence_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2014-04-15").
patient_(alice_and_bob,home).

% Test
:- s152_d_2_H(alice,bob,2018,_,_,_).
:- halt.

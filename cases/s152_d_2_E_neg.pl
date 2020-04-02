% Text
% Charlie is Bob's father since April 15th, 2014. Alice is Charlie's sister since October 12th, 1992.

% Question
% Alice bears a relationship to Bob under section 152(d)(2)(E). Contradiction

% Facts
:- [statutes/prolog/init].
father_(charlie_and_bob).
agent_(charlie_and_bob,charlie).
patient_(charlie_and_bob,bob).
start_(charlie_and_bob,"2014-04-15").
sister_(alice_and_charlie).
agent_(alice_and_charlie,alice).
patient_(alice_and_charlie,charlie).
start_(alice_and_charlie,"1992-10-12").

% Test
:- \+ s152_d_2_E(alice,bob,_,_,_).
:- halt.

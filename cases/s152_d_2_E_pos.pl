% Text
% Charlie is Alice's father since April 15th, 2014. Bob is Charlie's brother since October 12th, 1992.

% Question
% Alice bears a relationship to Bob under section 152(d)(2)(E). Entailment

% Facts
:- [statutes/prolog/init].
father_(alice_and_bob).
agent_(alice_and_bob,bob).
patient_(alice_and_bob,alice).
start_(alice_and_bob,"2014-04-15").
brother_(bob_and_charlie).
agent_(bob_and_charlie,bob).
patient_(bob_and_charlie,charlie).
start_(bob_and_charlie,"1992-10-12").

% Test
:- s152_d_2_E(alice,bob,_,_,_).
:- halt.

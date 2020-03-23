% Text
% Charlie is Alice's father since April 15th, 2014. Bob is Charlie's brother since October 12th, 1992.

% Question
% Alice bears a relationship to Bob under section 152(d)(2)(D) for the year 2018. Contradiction

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
:- \+ (s152_d_2_D(alice,bob,Start_relationship,End_relationship),
    var(End_relationship),
    first_day_year(2018,First_day),
    is_before(Start_relationship,First_day)).
:- halt.

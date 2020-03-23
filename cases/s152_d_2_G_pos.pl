% Text
% Charlie is Bob's father since April 15th, 2014. Alice married Bob on October 12th, 1992.

% Question
% Alice bears a relationship to Charlie under section 152(d)(2)(G) for the year 2018. Entailment

% Facts
:- [statutes/prolog/init].
father_(charlie_and_bob).
agent_(charlie_and_bob,charlie).
patient_(charlie_and_bob,bob).
start_(charlie_and_bob,"2014-04-15").
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"1992-10-12").

% Test
:- s152_d_2_G(alice,charlie,Start_relationship,End_relationship),
    var(End_relationship),
    first_day_year(2018,First_day),
    is_before(Start_relationship,First_day).
:- halt.

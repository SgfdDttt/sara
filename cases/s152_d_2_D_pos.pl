% Text
% Charlie is Bob's father since April 15th, 1995. Dorothy is Bob's mother. Alice married Charlie on August 8th, 2018.

% Question
% Alice bears a relationship to Bob under section 152(d)(2)(D) for the year 2019. Entailment

% Facts
:- [statutes/prolog/init].
father_(charlie_and_bob).
agent_(charlie_and_bob,charlie).
patient_(charlie_and_bob,bob).
start_(charlie_and_bob,"1995-04-15").
mother_(dorothy_and_bob).
agent_(dorothy_and_bob,dorothy).
patient_(dorothy_and_bob,bob).
start_(dorothy_and_bob,"1995-04-15").
marriage_(alice_and_charlie).
agent_(alice_and_charlie,alice).
agent_(alice_and_charlie,charlie).
start_(alice_and_charlie,"2018-08-08").

% Test
:- s152_d_2_D(alice,bob,Start_relationship,End_relationship),
    var(End_relationship),
    first_day_year(2019,First_day),
    is_before(Start_relationship,First_day).
:- halt.

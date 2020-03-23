% Text
% Alice and Bob got married on Feb 3rd, 2013. Alice died on July 9th, 2014. Alice was a nonresident alien. From 2004 to 2019, Bob furnished the costs of maintaining the home where he and and his father Charlie lived during that time. Charlie had no income from 2015 to 2019. Bob's gross income in 2015 was $678323. Bob takes the standard deduction in 2015.

% Question
% How much tax does Bob have to pay in 2015? $245359

% Facts
:- [statutes/prolog/init].
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2013-02-03").
death_(alice_dies).
agent_(alice_dies,alice).
start_(alice_dies,"2014-07-09").
nonresident_alien_(alice_is_nra).
agent_(alice_is_nra,alice).
father_(charlie_is_father).
patient_(charlie_is_father,charlie).
agent_(charlie_is_father,bob).
residence_(charlie_and_bob_residence).
agent_(charlie_and_bob_residence,charlie).
agent_(charlie_and_bob_residence,bob).
patient_(charlie_and_bob_residence,bob_s_house).
start_(charlie_and_bob_residence,"2004-01-01").
end_(charlie_and_bob_residence,"2019-12-31").
bob_household_maintenance(Year,Event,Start_day,End_day) :-
    between(2004,2019,Year),
    atom_concat('bob_maintains_household_',Year,Event),
    first_day_year(Year,Start_day),
    last_day_year(Year,End_day).
payment_(Event) :- bob_household_maintenance(_,Event,_,_).
agent_(Event,bob) :- bob_household_maintenance(_,Event,_,_).
amount_(Event,1) :- bob_household_maintenance(_,Event,_,_).
purpose_(Event,bob_s_house) :- bob_household_maintenance(_,Event,_,_).
start_(Event,Start_day) :- bob_household_maintenance(_,Event,Start_day,_).
end_(Event,End_day) :- bob_household_maintenance(_,Event,_,End_day).
income_(bob_income).
agent_(bob_income,bob).
amount_(bob_income,678323).
start_(bob_income,"2015-12-31").

% Test
:- tax(bob,2015,245359).
:- halt.

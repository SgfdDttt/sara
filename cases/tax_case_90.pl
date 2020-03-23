% Text
% Alice and Bob got married on Feb 3rd, 1992. Alice died on July 9th, 2014. From 2015 to 2019, Bob furnished the costs of maintaining the home where he and and his friend Charlie lived during that time, while Charlie had no income and was not the qualifying child of any taxpayer. Bob earned $304598 every year from 2015 to 2019.

% Question
% How much tax does Bob have to pay in 2018? $96641

% Facts
:- [statutes/prolog/init].
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"1992-02-03").
death_(alice_dies).
agent_(alice_dies,alice).
start_(alice_dies,"2014-07-09").
end_(alice_dies,"2014-07-09").
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,bob_s_house).
start_(bob_residence,"2015-01-01").
end_(bob_residence,"2019-12-31").
residence_(charlie_residence).
agent_(charlie_residence,charlie).
patient_(charlie_residence,bob_s_house).
start_(charlie_residence,"2015-01-01").
end_(charlie_residence,"2019-12-31").
bob_household_maintenance(Year,Event,Start_day,End_day) :-
    between(2015,2019,Year),
    atom_concat('bob_maintains_household_',Year,Event),
    first_day_year(Year,Start_day),
    last_day_year(Year,End_day).
payment_(Event) :- bob_household_maintenance(_,Event,_,_).
agent_(Event,bob) :- bob_household_maintenance(_,Event,_,_).
amount_(Event,1) :- bob_household_maintenance(_,Event,_,_).
purpose_(Event,bob_s_house) :- bob_household_maintenance(_,Event,_,_).
start_(Event,Start_day) :- bob_household_maintenance(_,Event,Start_day,_).
end_(Event,End_day) :- bob_household_maintenance(_,Event,_,End_day).
bob_income(Year,Event,Day) :-
    between(2015,2019,Year),
    atom_concat('bob_income_',Year,Event),
    last_day_year(Year,Day).
income_(Event) :- bob_income(_,Event,_).
agent_(Event,bob) :- bob_income(_,Event,_).
amount_(Event,304598) :- bob_income(_,Event,_).
start_(Event,Day) :- bob_income(_,Event,Day).

% Test
:- tax(bob,2018,96641).
:- halt.

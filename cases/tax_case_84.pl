% Text
% Bob and Alice got married on Feb 3rd, 1992. Bob and Alice have a child, Charlie, born October 9th, 2000. Bob died on July 9th, 2014. From 2004 to 2019, Alice furnished the costs of maintaining the home where he and Charlie lived during that time. Alice's gross income for the year 2017 is $25561. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $2574

% Facts
:- [statutes/prolog/init].
marriage_(bob_and_alice).
agent_(bob_and_alice,bob).
agent_(bob_and_alice,alice).
start_(bob_and_alice,"1992-02-03").
death_(bob_dies).
agent_(bob_dies,bob).
start_(bob_dies,"2014-07-09").
end_(bob_dies,"2014-07-09").
son_(charlie_is_son).
agent_(charlie_is_son,charlie).
patient_(charlie_is_son,bob).
patient_(charlie_is_son,alice).
start_(charlie_is_son,"2000-10-09").
residence_(charlie_and_alice_residence).
agent_(charlie_and_alice_residence,charlie).
agent_(charlie_and_alice_residence,alice).
patient_(charlie_and_alice_residence,alice_s_house).
start_(charlie_and_alice_residence,"2004-01-01").
end_(charlie_and_alice_residence,"2019-12-31").
alice_household_maintenance(Year,Event,Start_day,End_day) :-
    between(2004,2019,Year),
    atom_concat('alice_maintains_household_',Year,Event),
    first_day_year(Year,Start_day),
    last_day_year(Year,End_day).
payment_(Event) :- alice_household_maintenance(_,Event,_,_).
agent_(Event,alice) :- alice_household_maintenance(_,Event,_,_).
amount_(Event,1) :- alice_household_maintenance(_,Event,_,_).
purpose_(Event,alice_s_house) :- alice_household_maintenance(_,Event,_,_).
start_(Event,Start_day) :- alice_household_maintenance(_,Event,Start_day,_).
end_(Event,End_day) :- alice_household_maintenance(_,Event,_,End_day).
income_(alice_income_2017).
agent_(alice_income_2017,alice).
amount_(alice_income_2017,25561).
start_(alice_income_2017,"2017-12-31").

% Test
:- tax(alice,2017,2574).
:- halt.

% Text
% Alice and Bob got married on Feb 3rd, 1992. Alice died on July 9th, 2014. From 2004 to 2019, Bob furnished the costs of maintaining the home where he and his son Charlie lived during that time. Bob is entitled to a deduction for Charlie under section 151(c) for the years 2015 to 2019.

% Question
% Section 2(b)(1) applies to Bob in 2016. Contradiction

% Facts
:- discontiguous s151_c_applies/3.
:- [statutes/prolog/init].
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"1992-02-03").
death_(alice_dies).
agent_(alice_dies,alice).
start_(alice_dies,"2014-07-09").
end_(alice_dies,"2014-07-09").
son_(charlie_is_son).
agent_(charlie_is_son,charlie).
patient_(charlie_is_son,bob).
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
s151_c_applies(bob,charlie,Year) :- between(2015,2019,Year).

% Test
:- \+ s2_b_1(bob,_,_,2016).
:- halt.

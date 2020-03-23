% Text
% Alice's and Bob's gross incomes for the year 2013 are $71879 and $11213 respectively. Alice and Bob got married on Feb 3rd, 1992. Alice and Bob have a child, Charlie, born October 9th, 2000. From 2004 to 2019, Bob furnished 40% of the costs of maintaining the home where he and Charlie lived during that time, and Alice furnished the remaining costs. In 2013, Alice and Bob file jointly and take the standard deduction.

% Question
% How much tax does Alice have to pay in 2013? $15109

% Facts
:- [statutes/prolog/init].
income_(alice_income_2013).
agent_(alice_income_2013,alice).
amount_(alice_income_2013,71879).
start_(alice_income_2013,"2013-12-31").
income_(bob_income_2013).
agent_(bob_income_2013,bob).
amount_(bob_income_2013,11213).
start_(bob_income_2013,"2013-12-31").
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"1992-02-03").
son_(charlie_is_son).
agent_(charlie_is_son,charlie).
patient_(charlie_is_son,alice).
patient_(charlie_is_son,bob).
start_(charlie_is_son,"2000-10-09").
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
amount_(Event,40) :- bob_household_maintenance(_,Event,_,_).
purpose_(Event,bob_s_house) :- bob_household_maintenance(_,Event,_,_).
start_(Event,Start_day) :- bob_household_maintenance(_,Event,Start_day,_).
end_(Event,End_day) :- bob_household_maintenance(_,Event,_,End_day).
alice_household_maintenance(Year,Event,Start_day,End_day) :-
    between(2004,2019,Year),
    atom_concat('alice_maintains_household_',Year,Event),
    first_day_year(Year,Start_day),
    last_day_year(Year,End_day).
payment_(Event) :- alice_household_maintenance(_,Event,_,_).
agent_(Event,alice) :- alice_household_maintenance(_,Event,_,_).
amount_(Event,60) :- alice_household_maintenance(_,Event,_,_).
purpose_(Event,bob_s_house) :- alice_household_maintenance(_,Event,_,_).
start_(Event,Start_day) :- alice_household_maintenance(_,Event,Start_day,_).
end_(Event,End_day) :- alice_household_maintenance(_,Event,_,End_day).
joint_return_(joint_return).
agent_(joint_return,alice).
agent_(joint_return,bob).
start_(joint_return,"2013-01-01").
end_(joint_return,"2013-12-31").

% Test
:- tax(alice,2013,15109).
:- halt.

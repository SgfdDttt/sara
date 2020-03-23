% Text
% Alice and Bob got married on April 5th, 2012. Alice and Bob have a son, Charlie, who was born on September 16th, 2017. Alice and Charlie live in a home for which Alice furnished 40% of the maintenance costs, and Bob the remaining 60%, since September 16th, 2017. Alice and Bob file jointly from 2017 to 2019. Alice and Bob's incomes in 2018 were $36991 and $41990 respectively. Alice and Bob take the standard deduction. From 2017 to 2019, Bob lived separately.

% Question
% How much tax does Alice have to pay in 2018? $10598

% Facts
:- [statutes/prolog/init].
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2012-04-05").
son_(charlie_is_born).
agent_(charlie_is_born,charlie).
patient_(charlie_is_born,bob).
patient_(charlie_is_born,alice).
start_(charlie_is_born,"2017-09-16").
residence_(home).
agent_(home,alice).
agent_(home,charlie).
patient_(home,alice_s_house).
start_(home,"2017-09-16").
bob_household_maintenance(Year,Event,Start_day,End_day) :-
    between(2017,2117,Year), % avoid infinite forward loop
    atom_concat('bob_maintains_household_',Year,Event),
    (((Year==2017)->(Start_day="2017-09-16"));first_day_year(Year,Start_day)),
    last_day_year(Year,End_day).
payment_(Event) :- bob_household_maintenance(_,Event,_,_).
agent_(Event,bob) :- bob_household_maintenance(_,Event,_,_).
amount_(Event,60) :- bob_household_maintenance(_,Event,_,_).
purpose_(Event,home) :- bob_household_maintenance(_,Event,_,_).
start_(Event,Start_day) :- bob_household_maintenance(_,Event,Start_day,_).
end_(Event,End_day) :- bob_household_maintenance(_,Event,_,End_day).
alice_household_maintenance(Year,Event,Start_day,End_day) :-
    between(2017,2117,Year), % avoid infinite forward loop
    atom_concat('alice_maintains_household_',Year,Event),
    (((Year==2017)->(Start_day="2017-09-16"));first_day_year(Year,Start_day)),
    last_day_year(Year,End_day).
payment_(Event) :- alice_household_maintenance(_,Event,_,_).
agent_(Event,alice) :- alice_household_maintenance(_,Event,_,_).
amount_(Event,40) :- alice_household_maintenance(_,Event,_,_).
purpose_(Event,home) :- alice_household_maintenance(_,Event,_,_).
start_(Event,Start_day) :- alice_household_maintenance(_,Event,Start_day,_).
end_(Event,End_day) :- alice_household_maintenance(_,Event,_,End_day).
joint_return_alice_and_bob(Year,Event,Start_day,End_day) :-
    between(2017,2019,Year),
    atom_concat('alice_and_bob_joint_return_',Year,Event),
    first_day_year(Year,Start_day),
    last_day_year(Year,End_day).
joint_return_(Event) :- joint_return_alice_and_bob(_,Event,_,_).
agent_(Event,alice) :- joint_return_alice_and_bob(_,Event,_,_).
agent_(Event,bob) :- joint_return_alice_and_bob(_,Event,_,_).
start_(Event,Day) :- joint_return_alice_and_bob(_,Event,Day,_).
end_(Event,Day) :- joint_return_alice_and_bob(_,Event,_,Day).
income_(alice_income_2018).
agent_(alice_income_2018,alice).
amount_(alice_income_2018,36991).
start_(alice_income_2018,"2018-12-31").
income_(bob_income_2018).
agent_(bob_income_2018,bob).
amount_(bob_income_2018,41990).
start_(bob_income_2018,"2018-12-31").
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,bob_s_house).
start_(bob_residence,"2017-01-01").
end_(bob_residence,"2019-12-31").

% Test
:- tax(alice,2018,10598).
:- halt.

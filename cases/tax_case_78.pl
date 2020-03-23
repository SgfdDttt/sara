% Text
% Alice and Bob got married on April 5th, 2012. Alice and Bob have a son, Charlie, who was born on September 16th, 2017. Alice and Charlie live in a home maintained by Alice since September 16th, 2017. Alice's gross income in 2019 is $73124. Alice and Bob file separate returns. Alice takes the standard deduction. In 2019, Bob has a different principal place of abode than Alice and Charlie.

% Question
% How much tax does Alice have to pay in 2019? $14470

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
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,alice_s_house).
start_(alice_residence,"2017-09-16").
residence_(charlie_residence).
agent_(charlie_residence,charlie).
patient_(charlie_residence,alice_s_house).
start_(charlie_residence,"2017-09-16").
alice_household_maintenance(Year,Event,Start_day,End_day) :-
    between(2017,2117,Year), % avoid infinite forward loop
    atom_concat('alice_maintains_household_',Year,Event),
    (((Year==2017)->(Start_day="2017-09-16"));first_day_year(Year,Start_day)),
    last_day_year(Year,End_day).
payment_(Event) :- alice_household_maintenance(_,Event,_,_).
agent_(Event,alice) :- alice_household_maintenance(_,Event,_,_).
amount_(Event,1) :- alice_household_maintenance(_,Event,_,_).
purpose_(Event,alice_s_house) :- alice_household_maintenance(_,Event,_,_).
start_(Event,Start_day) :- alice_household_maintenance(_,Event,Start_day,_).
end_(Event,End_day) :- alice_household_maintenance(_,Event,_,End_day).
income_(alice_income_2019).
agent_(alice_income_2019,alice).
amount_(alice_income_2019,73124).
start_(alice_income_2019,"2019-12-31").
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,bob_s_house).
start_(bob_residence,"2019-01-01").
end_(bob_residence,"2019-12-31").

% Test
:- tax(alice,2019,14470).
:- halt.

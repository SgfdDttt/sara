% Text
% Alice and Bob got married on April 5th, 2012. Alice and Bob have a son, Charlie, who was born on September 16th, 2017. Alice and Charlie live in a home maintained by Alice since September 16th, 2017. Alice is entitled to a deduction for Charlie under section 151(c) for the years 2017 to 2019. Bob lived in the same house as Alice and Charlie from September 16th, 2017 until October 10th, 2018.

% Question
% Section 7703(b)(3) applies to Alice maintaining her home for the year 2018. Contradiction

% Facts
:- discontiguous s151_c_applies/3.
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
alice_household_maintenance(Year,Event,Start_day,End_day) :-
    between(2017,2117,Year), % avoid infinite forward loop
    atom_concat('alice_maintains_household_',Year,Event),
    (((Year==2017)->(Start_day="2017-09-16"));first_day_year(Year,Start_day)),
    last_day_year(Year,End_day).
payment_(Event) :- alice_household_maintenance(_,Event,_,_).
agent_(Event,alice) :- alice_household_maintenance(_,Event,_,_).
amount_(Event,1) :- alice_household_maintenance(_,Event,_,_).
purpose_(Event,home) :- alice_household_maintenance(_,Event,_,_).
start_(Event,Start_day) :- alice_household_maintenance(_,Event,Start_day,_).
end_(Event,End_day) :- alice_household_maintenance(_,Event,_,End_day).
s151_c_applies(alice,charlie,Year) :- between(2017,2019,Year).
residence_(bob_lives_alice_house).
agent_(bob_lives_alice_house,bob).
patient_(bob_lives_alice_house,alice_s_house).
start_(bob_lives_alice_house,"2017-09-16").
end_(bob_lives_alice_house,"2018-10-10").

% Test
:- \+ s7703_b_3(alice,_,alice_s_house,2018).
:- halt.

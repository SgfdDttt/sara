% Text
% Alice and Bob got married on Feb 3rd, 1992. Alice and Bob have a child, Charlie, born October 9th, 2000. From 2004 to 2019, Bob furnished the costs of maintaining the home where Alice, Bob and Charlie lived during that time. Charlie married Dan on Feb 14th, 2018 and they file separate tax returns in 2018. Dan's principal place of abode for 2018 is different from Charlie's. Alice's gross income in 2018 was $54232, and Bob's gross income was $43245. Alice and Bob file a joint return in 2018 and take the standard deduction.

% Question
% How much tax does Alice have to pay in 2018? $15777

% Facts
:- [statutes/prolog/init].
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"1992-02-03").
son_(charlie_is_son).
agent_(charlie_is_son,charlie).
patient_(charlie_is_son,alice).
patient_(charlie_is_son,bob).
start_(charlie_is_son,"2000-10-09").
residence_(abc_residence).
agent_(abc_residence,charlie).
agent_(abc_residence,bob).
patient_(abc_residence,bob_s_house).
start_(abc_residence,"2004-01-01").
end_(abc_residence,"2019-12-31").
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
marriage_(charlie_and_dan).
agent_(charlie_and_dan,dan).
agent_(charlie_and_dan,charlie).
start_(charlie_and_dan,"2018-02-14").
residence_(dan_residence).
agent_(dan_residence,dan).
patient_(dan_residence,dan_s_house).
start_(dan_residence,"2018-01-01").
end_(dan_residence,"2018-12-31").
income_(alice_income_2018).
agent_(alice_income_2018,alice).
amount_(alice_income_2018,54232).
start_(alice_income_2018,"2018-12-31").
income_(bob_income_2018).
agent_(bob_income_2018,bob).
amount_(bob_income_2018,43245).
start_(bob_income_2018,"2018-12-31").
joint_return_(alice_and_bob_joint_return).
agent_(alice_and_bob_joint_return,alice).
agent_(alice_and_bob_joint_return,bob).
start_(alice_and_bob_joint_return,"2018-01-01").
end_(alice_and_bob_joint_return,"2018-12-31").

% Test
:- tax(alice,2018,15777).
:- halt.

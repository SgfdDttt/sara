% Text
% Alice and Bob got married on Feb 3rd, 1992. Bob has a brother, Charlie, born October 9th, 2000. Alice died on July 9th, 2014. From 2004 to 2019, Bob furnished the costs of maintaining the home where he and Charlie lived during that time. In 2017, Charlie earned $312489. In 2017, Charlie filed a joint return with his spouse whom he married on Dec 1st, 2016.

% Question
% Section 2(b)(1)(A)(ii) applies to Bob in 2017. Contradiction

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
son_(charlie_is_brother).
agent_(charlie_is_brother,charlie).
patient_(charlie_is_brother,bob).
start_(charlie_is_brother,"2000-10-09").
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
income_(charlie_makes_money).
agent_(charlie_makes_money,charlie).
amount_(charlie_makes_money,312489).
start_(charlie_makes_money,"2017-12-31").
marriage_(charlie_marriage).
agent_(charlie_marriage,charlie).
agent_(charlie_marriage,spouse).
start_(charlie_marriage,"2016-12-01").
joint_return_(charlie_and_spouse_joint_return).
agent_(charlie_and_spouse_joint_return,charlie).
agent_(charlie_and_spouse_joint_return,spouse).
start_(charlie_and_spouse_joint_return,"2017-01-01").
end_(charlie_and_spouse_joint_return,"2017-12-31").

% Test
:- \+ s2_b_1_A_ii(bob,_,2017).
:- halt.

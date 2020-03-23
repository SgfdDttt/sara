% Text
% Alice and Bob got married on Feb 3rd, 1992. Alice has a child, Charlie, born October 9th, 2000. Alice died on July 9th, 2021. From 2011 to 2024, Bob furnished the costs of maintaining the home where he and Charlie lived during that time. In 2020, Charlie filed a joint return with his spouse whom he married on Dec 1st, 2019. Charlie earned $312489 in 2020.

% Question
% Section 2(a)(1)(B) applies to Bob in 2020. Contradiction

% Facts
:- [statutes/prolog/init].
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"1992-02-03").
death_(alice_dies).
agent_(alice_dies,alice).
start_(alice_dies,"2021-07-09").
son_(charlie_is_son).
agent_(charlie_is_son,charlie).
patient_(charlie_is_son,alice).
start_(charlie_is_son,"2000-10-09").
residence_(charlie_and_bob_residence).
agent_(charlie_and_bob_residence,charlie).
agent_(charlie_and_bob_residence,bob).
patient_(charlie_and_bob_residence,bob_s_house).
start_(charlie_and_bob_residence,"2011-01-01").
end_(charlie_and_bob_residence,"2024-12-31").
bob_household_maintenance(Year,Event,Start_day,End_day) :-
    between(2011,2024,Year),
    atom_concat('bob_maintains_household_',Year,Event),
    first_day_year(Year,Start_day),
    last_day_year(Year,End_day).
payment_(Event) :- bob_household_maintenance(_,Event,_,_).
agent_(Event,bob) :- bob_household_maintenance(_,Event,_,_).
amount_(Event,1) :- bob_household_maintenance(_,Event,_,_).
purpose_(Event,bob_s_house) :- bob_household_maintenance(_,Event,_,_).
start_(Event,Start_day) :- bob_household_maintenance(_,Event,Start_day,_).
end_(Event,End_day) :- bob_household_maintenance(_,Event,_,End_day).
marriage_(charlie_marriage).
agent_(charlie_marriage,charlie).
agent_(charlie_marriage,spouse).
start_(charlie_marriage,"2019-12-01").
joint_return_(charlie_and_spouse_joint_return).
agent_(charlie_and_spouse_joint_return,charlie).
agent_(charlie_and_spouse_joint_return,spouse).
start_(charlie_and_spouse_joint_return,"2020-01-01").
end_(charlie_and_spouse_joint_return,"2020-12-31").
income_(charlie_makes_money).
agent_(charlie_makes_money,charlie).
amount_(charlie_makes_money,312489).
start_(charlie_makes_money,"2020-12-31").

% Test
:- \+ s2_a_1_B(bob,_,_,2020).
:- halt.

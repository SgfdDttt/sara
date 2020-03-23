% Text
% Alice and Bob got married on Feb 3rd, 1992. Alice and Bob have a child, Charlie, born October 9th, 2000. From 2004 to 2019, Bob furnished the costs of maintaining the home where he and Charlie lived during that time. From 2015 to 2018, Alice had a different principal place of abode. In 2017, Alice was paid $33200, and Bob's income was $32311. Alice was born March 2nd, 1950 and Bob was born March 3rd, 1955. In 2017, Alice and Bob file jointly and take the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $10018

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
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,bob_s_house).
start_(bob_residence,"2004-01-01").
end_(bob_residence,"2019-12-31").
residence_(charlie_residence).
agent_(charlie_residence,charlie).
patient_(charlie_residence,bob_s_house).
start_(charlie_residence,"2004-01-01").
end_(charlie_residence,"2019-12-31").
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
residence_(alice_residence).
agent_(alice_residence,bob).
patient_(alice_residence,alice_s_house).
start_(alice_residence,"2015-01-01").
end_(alice_residence,"2018-12-31").
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
amount_(alice_is_paid,33200).
income_(bob_income).
agent_(bob_income,bob).
start_(bob_income,"2017-12-31").
amount_(bob_income,32311).
birth_(alice_is_born).
agent_(alice_is_born,alice).
start_(alice_is_born,"1950-03-02").
end_(alice_is_born,"1950-03-02").
birth_(bob_is_born).
agent_(bob_is_born,bob).
start_(bob_is_born,"1955-03-03").
end_(bob_is_born,"1955-03-03").
joint_return_(alice_and_bob_joint_return).
agent_(alice_and_bob_joint_return,alice).
agent_(alice_and_bob_joint_return,bob).
start_(alice_and_bob_joint_return,"2017-01-01").
end_(alice_and_bob_joint_return,"2017-12-31").

% Test
:- tax(alice,2017,10018).
:- halt.
